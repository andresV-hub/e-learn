class Comment < ApplicationRecord

  include PublicActivity::Model
  # El controlador es nil fuera de una petición (seeds, consola, tareas rake,
  # jobs): sin el navegador seguro, cualquier alta desde ahí revienta con
  # NoMethodError. En esos casos la actividad se registra sin propietario.
  tracked owner: Proc.new { |controller, model| controller&.current_user }

  belongs_to :user, counter_cache: true
  belongs_to :lesson, counter_cache: true
  #User.find_each { |user| User.reset_counters(user.id, :comments) }  
  #Lesson.find_each { |lesson| Lesson.reset_counters(lesson.id, :comments) }
  validates :content, presence: true

  def to_s
    content
  end

end 