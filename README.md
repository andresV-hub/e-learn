# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Pila técnica

Rails 8.1 sobre Ruby 3.4.9 y PostgreSQL. Los assets los sirve **Propshaft**:
**esbuild** empaqueta el JavaScript y **Sass** compila las hojas de estilo, y
ambos escriben en `app/assets/builds/`. Hotwire **Turbo** sustituye a Turbolinks
y a rails-ujs.

| Comando | Qué hace |
| --- | --- |
| `yarn build` | Empaqueta `app/javascript/application.js` con esbuild. |
| `yarn build:css` | Copia las fuentes de FontAwesome y compila `application.scss`. |

`bin/rails assets:precompile` invoca los dos automáticamente, vía
`jsbundling-rails` y `cssbundling-rails`.

## Docker

Hace falta Docker Engine 23+ (BuildKit).

### Desarrollo

```bash
docker compose up --build
```

| Servicio | Detalle |
| --- | --- |
| `db` | PostgreSQL 18 (Alpine). Publicado en el puerto **5433** del host para no chocar con un PostgreSQL local; se cambia con `POSTGRES_PORT`. |
| `web` | Rails en `http://localhost:3000`. El código se monta desde el host. |

El entrypoint ejecuta `rails db:prepare` al arrancar el servidor, así que la base
se crea, migra y siembra sola la primera vez. Si `node_modules` no existe todavía
(clon recién hecho), también instala las dependencias de JavaScript y construye
los assets.

Órdenes puntuales:

```bash
docker compose run --rm web bin/rails console
docker compose run --rm web bin/rails db:migrate
docker compose run --rm web yarn build          # tras tocar el JavaScript
docker compose run --rm web yarn build:css      # tras tocar las hojas de estilo
```

Tras cambiar el `Gemfile` o el `package.json`: `docker compose build web`.

### Producción

```bash
export RAILS_MASTER_KEY=$(cat config/master.key)
docker build --target production \
  --secret id=RAILS_MASTER_KEY,env=RAILS_MASTER_KEY \
  -t e-learn:prod .
```

La imagen final (~840 MB) no lleva compilador, ni Node, ni `node_modules`, ni
gemas de desarrollo; corre como usuario sin privilegios y sirve los assets ya
precompilados. La clave va como secreto de BuildKit, así que no queda grabada en
ninguna capa.

En ejecución hay que aportar por entorno:

- `DATABASE_URL`, p. ej. `postgres://usuario:clave@host:5432/e_learn_production`.
  Rails la superpone a `config/database.yml`, así que es la vía recomendada en
  contenedores.
- `SECRET_KEY_BASE` (o `RAILS_MASTER_KEY`, si el secreto vive en las credenciales).

### Configuración de la base de datos

`config/database.yml` lee `DATABASE_HOST`, `DATABASE_PORT`, `DATABASE_USER` y
`DATABASE_PASSWORD`. Sin esas variables el adaptador usa sus valores por
defecto, que es como se conecta la aplicación al ejecutarse directamente en el
host, fuera de Docker.

### Generación de PDFs

`wicked_pdf` usa el binario de `wkhtmltopdf-binary`, que funciona tanto en
desarrollo como en la imagen de producción. La gema `wkhtmltopdf-heroku` vive en
su propio grupo `:heroku` y queda excluida de la imagen: su binario está
compilado contra el stack Ubuntu de Heroku y no arranca sobre Debian.
