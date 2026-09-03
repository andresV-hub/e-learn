class Enrollment < ApplicationRecord
  belongs_to :course, counter_cache: true
  #Course.find_each { |course| Course.reset_counters(course.id, :enrollments) }  
  belongs_to :user, counter_cache: true
  #User.find_each { |user| User.reset_counters(user.id, :enrollments) }  
  
  validates :user, :course, presence: true
  validates_uniqueness_of :user_id, scope: :course_id  #user cant be subscribed to the same course twice
  validates_uniqueness_of :course_id, scope: :user_id  #user cant be subscribed to the same course twice
  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?
  validate :cant_subscribe_to_own_course  #user can't create a subscription if course.user == current_user.id
  
  scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }
  scope :reviewed, -> { where.not(review: [0, nil, ""]) }
  scope :latest_good_reviews, -> { order(rating: :desc, created_at: :desc).limit(3) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged


  def to_s
    user.to_s + " " + course.to_s
  end

  after_save do
    unless rating.nil? || rating.zero?
      course.update_rating
    end
  end

  after_destroy do
    course.update_rating
  end


  protected
  def cant_subscribe_to_own_course
    if self.new_record?
      if self.user_id.present?
        if self.user_id == course.user_id
          errors.add(:base, "You can not subscribe to your own course")
        end
      end
    end
  end

  # Ransack 4 dejó de exponer los atributos por defecto: hay que declarar
  # explícitamente qué se puede buscar y ordenar. La lista se ciñe a lo que usan
  # los formularios de búsqueda y los sort_link de las vistas, para no filtrar
  # columnas sensibles a través de la query string.
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at price rating review updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[course user]
  end
end
