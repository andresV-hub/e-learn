source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.9'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 8.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.6'
# Use Puma as the app server
gem 'puma', '~> 8.0'

# Asset pipeline: Propshaft sirve los assets ya construidos, esbuild empaqueta el
# JavaScript y Sass compila las hojas de estilo. Ambos escriben en
# app/assets/builds y se enganchan a `assets:precompile`.
#
# No se usa Importmap: la aplicación depende de once paquetes npm (jQuery UI,
# selectize, video.js, FontAwesome...), varios con CSS propio, que un empaquetador
# resuelve directamente.
gem 'propshaft'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
# Hotwire: Turbo replaces Turbolinks, Stimulus is available for new controllers.
gem 'turbo-rails'
gem 'stimulus-rails'

gem 'bootstrap', '~> 5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.13'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 5.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.18.4', require: false

gem 'haml-rails', '~> 3.1'
gem 'simple_form'
gem 'faker', '~> 3.8'
gem 'devise'
gem 'friendly_id', '~> 5.7'
gem 'sendgrid-ruby'
gem 'ransack'
gem 'public_activity'
gem 'rolify'
gem 'pundit'
gem 'exception_notification'
gem 'pagy'
gem 'chartkick'
gem 'groupdate'
gem 'rails-erd', group: :development #sudo apt-get install graphviz; bundle exec erd
gem 'ranked-model' #give serial/index numbers to items in a list
gem 'aws-sdk-s3', require: false #save images and files in production
gem 'active_storage_validations' #validate image and file uploads
gem 'image_processing' #needs libvips (apt install libvips42)
# image_processing 2.0 dejó de declarar el backend como dependencia: hay que
# pedirlo explícitamente. ruby-vips es el procesador por defecto desde
# load_defaults 7.0, y es más rápido y ligero que ImageMagick.
gem 'ruby-vips'
gem 'recaptcha'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'wicked_pdf' #PDF for Ruby on Rails
# Sin grupo a propósito: el binario de wkhtmltopdf-heroku está compilado contra
# el stack Ubuntu de Heroku y reclama libjpeg.so.8, que la imagen Docker
# (Debian) no tiene, así que allí no arranca. wkhtmltopdf-binary sí funciona en
# ambos sitios y es el que wicked_pdf encuentra primero en el PATH.
gem 'wkhtmltopdf-binary'
# Grupo propio, no :production, para que la imagen Docker pueda excluirla con
# BUNDLE_WITHOUT: su binario es de Ubuntu y allí no arranca, pero son 46 MB.
# Heroku instala este grupo igualmente, porque solo excluye :development y :test.
gem 'wkhtmltopdf-heroku', group: :heroku
gem 'wicked'#multistep forms
gem 'letter_opener', group: :development
gem 'cocoon'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: [:mri, :windows], require: 'debug/prelude'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 5.0'
  gem 'listen', '~> 3.10'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.40'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:windows, :jruby]
