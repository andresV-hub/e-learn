class CourseTag < ApplicationRecord
  belongs_to :course
  belongs_to :tag, counter_cache: true
  #Tag.find_each { |tag| Tag.reset_counters(tag.id, :course_tags) }

  # Ransack 4 dejó de exponer los atributos por defecto: hay que declarar
  # explícitamente qué se puede buscar y ordenar. La lista se ciñe a lo que usan
  # los formularios de búsqueda y los sort_link de las vistas, para no filtrar
  # columnas sensibles a través de la query string.
  def self.ransackable_attributes(_auth_object = nil)
    %w[course_id tag_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[course tag]
  end
end
