# syntax=docker/dockerfile:1

# Imagen multi-etapa. `development` es la que levanta docker-compose y trae el
# toolchain de compilación; `production` es la que se despliega y solo lleva las
# bibliotecas de ejecución. Mantener RUBY_VERSION sincronizado con .ruby-version.
ARG RUBY_VERSION=3.4.9


# --- base: dependencias de sistema comunes a todas las etapas ----------------
FROM docker.io/library/ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# libpq5         -> biblioteca cliente de PostgreSQL que enlaza la gema pg
# libvips42      -> variantes de Active Storage. Desde load_defaults 7.0 el
#                   procesador por defecto es vips, no ImageMagick; lo carga por
#                   FFI la gema ruby-vips
# poppler-utils  -> previsualización de PDFs adjuntos en Action Text
#                   (blob.representation sobre un PDF)
# libjemalloc2   -> lo precarga bin/docker-entrypoint; reduce la fragmentación de
#                   memoria de Ruby bajo Puma
# libxrender1, libxext6, libfontconfig1, libjpeg62-turbo, fonts-dejavu-core
#                -> objetos compartidos contra los que enlaza el binario de
#                   wkhtmltopdf que empaqueta la gema wkhtmltopdf-binary
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        curl \
        fonts-dejavu-core \
        libfontconfig1 \
        libjemalloc2 \
        libjpeg62-turbo \
        libpq5 \
        libvips42 \
        libxext6 \
        libxrender1 \
        poppler-utils && \
    rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH=/usr/local/bundle


# --- build: toolchain para gemas nativas y para construir los assets ---------
FROM base AS build

ARG NODE_VERSION=22

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        build-essential \
        ca-certificates \
        git \
        gnupg \
        libpq-dev \
        pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Node y Yarn: esbuild empaqueta el JavaScript y Sass compila las hojas de
# estilo. Se instalan desde NodeSource porque la versión de Debian va muy por
# detrás. Ambos son necesarios en la etapa de build de producción, no solo en
# desarrollo, porque `assets:precompile` invoca los scripts de package.json.
RUN curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | bash - && \
    apt-get install --no-install-recommends -y nodejs && \
    npm install --global yarn && \
    npm cache clean --force && \
    rm -rf /var/lib/apt/lists/*


# --- development: lo que usa docker-compose ----------------------------------
FROM build AS development

# graphviz lo necesita rails-erd para dibujar el diagrama entidad-relación.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y graphviz && \
    rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV=development

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf "${BUNDLE_PATH}"/ruby/*/cache

# wkhtmltopdf-binary empaqueta ~28 binarios comprimidos, uno por distribución y
# arquitectura, y ocupa 436 MB. La imagen es Debian (el gem mapea debian_13 ->
# debian_12), así que solo se usa uno: se descarta el resto, se descomprime aquí
# el que queda y se borran ya todos los .gz.
#
# La descompresión tiene que ocurrir en el build: el gem la hace de forma
# perezosa en el primer uso, escribiendo dentro del directorio de la gema, y en
# producción el proceso corre como usuario sin privilegios y no puede.
RUN find "${BUNDLE_PATH}" -name 'wkhtmltopdf_*.gz' \
        ! -name "wkhtmltopdf_debian_12_$(dpkg --print-architecture).gz" -delete && \
    bundle exec wkhtmltopdf --version && \
    find "${BUNDLE_PATH}" -name 'wkhtmltopdf_*.gz' -delete

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

# El repositorio se edita en Windows: normalizamos los finales de línea de los
# binstubs y les devolvemos el bit de ejecución, que NTFS no conserva.
RUN sed -i 's/\r$//' bin/* && chmod +x bin/*

# Primera construcción de los assets, para que la imagen sirva algo desde el
# arranque. En desarrollo se rehace con `yarn build` / `yarn build:css`.
RUN yarn build && yarn build:css

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]


# --- prod_build: gemas de producción y assets precompilados ------------------
FROM build AS prod_build

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT="development test heroku"

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# wkhtmltopdf-binary empaqueta ~28 binarios comprimidos, uno por distribución y
# arquitectura, y ocupa 436 MB. La imagen es Debian (el gem mapea debian_13 ->
# debian_12), así que solo se usa uno: se descarta el resto, se descomprime aquí
# el que queda y se borran ya todos los .gz.
#
# La descompresión tiene que ocurrir en el build: el gem la hace de forma
# perezosa en el primer uso, escribiendo dentro del directorio de la gema, y en
# producción el proceso corre como usuario sin privilegios y no puede.
RUN find "${BUNDLE_PATH}" -name 'wkhtmltopdf_*.gz' \
        ! -name "wkhtmltopdf_debian_12_$(dpkg --print-architecture).gz" -delete && \
    bundle exec wkhtmltopdf --version && \
    find "${BUNDLE_PATH}" -name 'wkhtmltopdf_*.gz' -delete

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

RUN sed -i 's/\r$//' bin/* && chmod +x bin/*

RUN bundle exec bootsnap precompile app/ lib/

# Propshaft calcula su load path al arrancar la aplicación, y `assets:precompile`
# arranca la aplicación ANTES de invocar los builds de esbuild y Sass. Si estos
# directorios no existen todavía (.dockerignore los excluye, porque su contenido
# es generado), Propshaft no los registra y acaba publicando el .scss fuente en
# lugar del CSS compilado. Crearlos vacíos de antemano lo evita.
RUN mkdir -p app/assets/builds app/assets/fonts

# SECRET_KEY_BASE_DUMMY cubre el secret_key_base, pero RAILS_MASTER_KEY sigue
# haciendo falta: los initializers (config/initializers/devise.rb) leen
# credentials al arrancar la aplicación. Se pasa como secreto de BuildKit para
# que no quede grabado en ninguna capa de la imagen:
#
#   docker build --target production \
#     --secret id=RAILS_MASTER_KEY,env=RAILS_MASTER_KEY -t e-learn:prod .
# jsbundling-rails y cssbundling-rails enganchan `yarn build` y `yarn build:css`
# a esta tarea, así que aquí se construyen también el JavaScript y el CSS.
RUN --mount=type=secret,id=RAILS_MASTER_KEY,env=RAILS_MASTER_KEY,required=false \
    SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

# node_modules solo hace falta para construir: los assets ya están compilados en
# public/assets, así que no viaja a la imagen final.
RUN rm -rf node_modules


# --- production: imagen final, sin toolchain ni código fuente de build -------
FROM base AS production

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_WITHOUT="development test heroku" \
    RAILS_LOG_TO_STDOUT=1 \
    RAILS_SERVE_STATIC_FILES=1

COPY --from=prod_build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=prod_build /rails /rails

# Ejecutar como usuario sin privilegios. storage/ y tmp/ son los únicos
# directorios en los que la aplicación escribe en tiempo de ejecución.
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p log storage tmp && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
