require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Make code changes take effect immediately without server restart.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable Action Controller caching. By default Action Controller caching is disabled.
  # Run rails dev:cache to toggle Action Controller caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = { 'cache-control' => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  #
  # :local, no :amazon. Apuntar a S3 en desarrollo exige credenciales de AWS en
  # las credenciales cifradas; sin ellas, cualquier subida (la portada de un
  # curso, el vídeo de una lección) aborta con Aws::Errors::MissingCredentialsError
  # y el arranque llena el log de intentos de leer el perfil de instancia.
  # Producción mantiene :amazon.
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  # Para inspeccionar los correos en el navegador en lugar de descartarlos:
  # config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.perform_deliveries = true

  # Host que compone las URLs de los mailers. El entorno de desarrollo es ahora
  # el contenedor de docker-compose, que publica el puerto 3000 en el host.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Append comments with runtime information tags to SQL queries in logs.
  config.active_record.query_log_tags_enabled = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Detección de cambios en código, rutas, locales y assets.
  #
  # EventedFileUpdateChecker (el de la gema listen) es más eficiente, pero se
  # apoya en inotify, y los bind mounts de Docker Desktop en Windows no propagan
  # esos eventos al contenedor: Rails no se entera de nada y hay que reiniciar a
  # mano tras cada edición. Propshaft también cuelga de este watcher, así que sin
  # él seguía sirviendo el bundle anterior aunque esbuild ya lo hubiera
  # reconstruido. FileUpdateChecker consulta las marcas de tiempo en cada
  # petición: gasta algo más de CPU, pero funciona en el bind mount.
  config.file_watcher = ActiveSupport::FileUpdateChecker

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end
