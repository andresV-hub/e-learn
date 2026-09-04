class Course < ApplicationRecord
    
    belongs_to :user, counter_cache: true
    #User.find_each { |user| User.reset_counters(user.id, :courses) }
    
    has_many :lessons, dependent: :destroy, inverse_of: :course
    has_many :enrollments, dependent: :restrict_with_error
    has_many :user_lessons, through: :lessons
    has_many :course_tags, inverse_of: :course, dependent: :destroy
    has_many :tags, through: :course_tags
    accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true
    has_one_attached :avatar
    #validates :avatar, attached: true, 
    validates :avatar, presence: true, on: :update
    validates :avatar,  
      content_type: ['image/png', 'image/jpeg'], # 'image/jpg' no es un tipo MIME real: active_storage_validations 4 lo rechaza 
      size: { less_than: 500.kilobytes , message: 'size should be under 500 kilobytes' }
    validates :title, uniqueness: true
    
    scope :latest, -> { limit(3).order(created_at: :desc) }
    scope :top_rated, -> { limit(3).order(average_rating: :desc, created_at: :desc) }
    scope :popular, -> { limit(3).order(enrollments_count: :desc, created_at: :desc) }
    scope :published, -> { where(published: true) }
    scope :unpublished, -> { where(published: false) }
    scope :approved, -> { where(approved: true) }
    scope :unapproved, -> { where(approved: false) }
    
    validates :title, :short_description, :language, :price, :level,  presence: true
    validates :description, length: { minimum: 5 }
    validates :short_description, length: { maximum: 300 }
    validates :title, uniqueness: true, length: { maximum: 70 }
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validate :lesson_titles_must_not_repeat
    has_rich_text :description
    
    extend FriendlyId
    friendly_id :title, use: :slugged
    
    def to_s
        title
    end

    # El asistente guarda todas las lecciones del paso en la misma transacción,
    # así que la validación de unicidad de Lesson no ve a sus hermanas todavía
    # sin guardar: dos lecciones con el mismo título generaban el mismo slug y
    # el formulario moría con PG::UniqueViolation (error 500). Se comparan aquí
    # los títulos que llegan en el mismo envío, que es donde sí se ven.
    #
    # Se mira lessons.target, no la asociación completa, para no cargar el
    # temario entero en cada guardado del curso.
    def lesson_titles_must_not_repeat
      titles = lessons.target.reject(&:marked_for_destruction?)
                             .map { |lesson| lesson.title.to_s.strip.downcase }
                             .reject(&:blank?)
      repeated = titles.tally.select { |_title, count| count > 1 }.keys
      return if repeated.empty?

      errors.add(:base, "Lesson titles must be different from each other: #{repeated.join(', ')}")
    end
    
    def update_rating
      if enrollments.any? && enrollments.where.not(rating: nil).any?
        update_column :average_rating, (enrollments.average(:rating).round(2).to_f)
      else
        update_column :average_rating, (0)
      end
    end
      
    # Devolvía lo contrario de lo que anuncia su nombre (true cuando NO había
    # matrícula) y CoursePolicy#show? lo leía en positivo, así que cualquier
    # usuario registrado podía abrir el borrador de otro. Ahora responde a la
    # pregunta que formula.
    def bought?(user)
      user.present? && enrollments.exists?(user_id: user.id)
    end
    
    def progress(user)
      unless self.lessons_count == 0
        user_lessons.where(user: user).count/self.lessons_count.to_f*100
      end
    end
  
      LANGUAGES = [ :"English", :"Spanish", :"Portuguese", :"French", :"Italian", :"Russian"]
      def self.languages
        LANGUAGES.map { |language| [language, language] }
      end
    
    LEVELS = [:"All Levels", :"Beginner", :"Intermediate", :"Advanced"]
      def self.levels
        LEVELS.map { |level| [level, level] }
      end
      
     include PublicActivity::Model
      # El controlador es nil fuera de una petición (seeds, consola, tareas rake,
      # jobs): sin el navegador seguro, cualquier alta desde ahí revienta con
      # NoMethodError. En esos casos la actividad se registra sin propietario.
      tracked owner: Proc.new { |controller, model| controller&.current_user }

    # Ransack 4 dejó de exponer los atributos por defecto: hay que declarar
    # explícitamente qué se puede buscar y ordenar. La lista se ciñe a lo que usan
    # los formularios de búsqueda y los sort_link de las vistas, para no filtrar
    # columnas sensibles a través de la query string.
    def self.ransackable_attributes(_auth_object = nil)
      %w[average_rating created_at enrollments_count language lessons_count level price short_description title updated_at]
    end

    def self.ransackable_associations(_auth_object = nil)
      %w[course_tags enrollments tags user]
    end
end
