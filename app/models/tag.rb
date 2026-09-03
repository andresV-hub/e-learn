class Tag < ApplicationRecord
  has_many :course_tags, dependent: :destroy
  has_many :courses, through: :course_tags

	validates :name, length: {minimum: 1, maximum: 25}, uniqueness: true

	def to_s
		name
	end

	def popular_name
	  "#{name.to_s}: #{course_tags_count.to_s}"
	end

  # Ransack 4 dejó de exponer los atributos por defecto: hay que declarar
  # explícitamente qué se puede buscar y ordenar. La lista se ciñe a lo que usan
  # los formularios de búsqueda y los sort_link de las vistas, para no filtrar
  # columnas sensibles a través de la query string.
  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[course_tags courses]
  end
end
