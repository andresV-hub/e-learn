require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ELearn
  class Application < Rails::Application
    config.load_defaults 8.1
    
    if Rails.env.development? #for rails-erd gem to generate a diagram
      def eager_load!
        Zeitwerk::Loader.eager_load_all
      end
    end
    
    # Permitir vídeo y audio embebidos dentro del contenido de Action Text.
    #
    # allowed_tags/allowed_attributes son nil por defecto: en ese caso Action
    # Text delega en las listas del propio sanitizador. Hay que partir de esas
    # listas, porque asignar solo las etiquetas extra dejaría fuera todas las
    # habituales (p, strong, a...) y vaciaría el texto enriquecido.
    config.to_prepare do
      helper    = ActionText::ContentHelper
      sanitizer = helper.sanitizer.class

      helper.allowed_tags =
        (helper.allowed_tags || sanitizer.allowed_tags).to_a | %w[iframe audio video source]
      helper.allowed_attributes =
        (helper.allowed_attributes || sanitizer.allowed_attributes).to_a | %w[style controls]
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
