# frozen_string_literal: true

# Configuración de Pagy 43.
# https://ddnexus.github.io/pagy/toolbox/configuration/options/
#
# Cambios respecto de la serie 9.x que usaba este proyecto:
#   - Pagy::DEFAULT  ->  Pagy::OPTIONS
#   - la opción :items  ->  :limit
#   - `require 'pagy/extras/bootstrap'` desapareció: el marcado de Bootstrap lo
#     genera ahora `pagy.series_nav(:bootstrap)` directamente sobre el objeto.
#   - Pagy::Backend  ->  Pagy::Method (se incluye en ApplicationController)
#   - Pagy::Frontend ya no existe ni hace falta incluirlo en los helpers.

Pagy::OPTIONS[:limit] = 20

Pagy::OPTIONS.freeze
