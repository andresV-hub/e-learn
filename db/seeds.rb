# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Idempotente a propósito: `db:prepare` siembra al crear la base, y el
# entrypoint de Docker lo ejecuta en cada primer arranque. Con `User.new` +
# `save!` la segunda pasada abortaba por email duplicado y dejaba el contenedor
# sin levantar.
user = User.find_or_initialize_by(email: 'admin@example.com')

if user.new_record?
  user.password = 'admin@example.com'
  user.password_confirmation = 'admin@example.com'
  user.skip_confirmation!
  user.save!
end

PublicActivity.enabled = false

# Datos de demostración: se generan una sola vez. Como Faker devuelve títulos
# aleatorios, repetir `db:seed` sin esta guarda añadía otros 30 cursos cada vez.
# El sufijo evita además que el catálogo corto de Faker::Educator choque contra
# la validación de unicidad de title dentro de una misma pasada.
if Course.none?
    30.times do |index|
        Course.create!(
            title: "#{Faker::Educator.course_name} ##{index + 1}",
            description: Faker::TvShows::GameOfThrones.quote,
            # Antes: User.find(2), que asumía un id concreto e inexistente en
            # una base recién creada.
            user_id: user.id,
            short_description: Faker::Quote.famous_last_words,
            language: Faker::ProgrammingLanguage.name,
            level: 'Beginner',
            price: Faker::Number.between(from: 1000, to: 20000)
        )
    end
end

PublicActivity.enabled = true