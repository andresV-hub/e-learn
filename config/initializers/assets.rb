# Be sure to restart your server when you modify this file.

# Propshaft sirve lo que dejan esbuild y Sass en app/assets/builds, más lo que
# haya en el resto de app/assets (imágenes y las fuentes de vendor copiadas).
#
# Aquí había un `config.assets.paths << Rails.root.join('node_modules')`, herencia
# de Webpacker: con Propshaft eso metía node_modules ENTERO en la lista de assets,
# y `assets:precompile` volcaba cada paquete a public/assets (más de 100
# directorios y ~1 GB en la imagen de producción). El empaquetador ya resuelve
# node_modules por su cuenta, así que la ruta no pinta nada.
#
# También se ha retirado `config.assets.version`, que era específico de Sprockets:
# Propshaft calcula el digest a partir del contenido de cada fichero.

# Sass compila app/assets/stylesheets hacia app/assets/builds, así que la carpeta
# de fuentes se saca del load path: si no, Propshaft publica también los .scss
# originales en public/assets, que nadie pide y no deberían quedar expuestos.
Rails.application.config.assets.excluded_paths << Rails.root.join("app/assets/stylesheets")
