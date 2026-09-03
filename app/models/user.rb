class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2, :github, :facebook]

  rolify

  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end
  
  def buy_course(course)
    self.enrollments.create(course: course, price: course.price)
  end
  
  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify
  has_many :comments, dependent: :nullify
  
  after_create :assign_default_role
  extend FriendlyId
  friendly_id :email, use: :slugged
  
  after_create do
    UserMailer.new_user(self).deliver_later
  end
  
  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
      #self.add_role(:teacher) #if you want any user to be able to create own courses
    end
  end
  
  validate :must_have_a_role, on: :update

  def online?
    updated_at > 2.minutes.ago
  end

  def view_lesson(lesson)
    user_lesson = self.user_lessons.where(lesson: lesson)
    if user_lesson.any?
      user_lesson.first.increment!(:impressions)
    else
      self.user_lessons.create(lesson: lesson)
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
     unless user
         user = User.create(
            email: data['email'],
            password: Devise.friendly_token[0,20],
            confirmed_at: Time.now, #autoconfirm user from omniauth
            name: access_token.info.name,
            image: access_token.info.image,
            provider: access_token.provider,
            uid: access_token.uid,
            token: access_token.credentials.token,
            expires_at: access_token.credentials.expires_at,
            expires: access_token.credentials.expires,
            refresh_token: access_token.credentials.refresh_token,
         )
     else #if user account exists - add additional data
        user.name = access_token.info.name
        user.image = access_token.info.image
        user.provider = access_token.provider
        user.uid = access_token.uid
        user.token = access_token.credentials.token
        user.expires_at = access_token.credentials.expires_at
        user.expires = access_token.credentials.expires
        user.refresh_token = access_token.credentials.refresh_token
        user.save!
     end
    user
  end

  private
  
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least one role")
    end
  end

  # Ransack 4 dejó de exponer los atributos por defecto: hay que declarar
  # explícitamente qué se puede buscar y ordenar. La lista se ciñe a lo que usan
  # los formularios de búsqueda y los sort_link de las vistas, para no filtrar
  # columnas sensibles a través de la query string.
  def self.ransackable_attributes(_auth_object = nil)
    %w[comments_count courses_count created_at email enrollments_count sign_in_count updated_at user_lessons_count]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments courses enrollments]
  end
end
