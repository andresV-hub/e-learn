# Imagen Corporativa del Producto — E-Learn

> **Este archivo es la fuente de verdad visual del producto.** La skill `rails-frontend-design` lo lee antes de cada propuesta y se atiene a lo que aquí se documente.
>
> **Identidad de marca completa** (posicionamiento, públicos, voz, logotipo): `docs/imagen-de-marca.md`. Este documento es su traducción a tokens, clases y componentes. Si los dos se contradicen, manda el de marca y este se corrige.
>
> **Reglas de oro**: (1) este archivo y el SCSS del proyecto deben permanecer alineados — si uno cambia, el otro también; (2) el naming es parte de la marca: las clases propias van con prefijo `el-` (de E-Learn) y las de Bootstrap 5 se usan tal cual, sin inventar variantes.

---

## 0. Versión actual de la imagen

- **Producto**: E-Learn — marketplace de cursos online (estudiante / profesor / administrador)
- **Estilo de marca**: azul de marca del birrete del logotipo sobre navy corporativo, superficies blancas, mucho aire
- **Stack real**: Rails 8.1 + **HAML** + **Bootstrap 5.3** + **Font Awesome 5** + simple_form + Pagy + Trix/Action Text + Video.js + Selectize + Cocoon
- **Estado**: ✅ **documento sincronizado con el SCSS.** Los tokens viven en `app/assets/stylesheets/_brand.scss` (variables de marca + overrides de Bootstrap) y los componentes `el-*` en `_components.scss`. Las vistas HAML están migradas.

> **Aviso para la skill:** los tokens de §2 existen como variables Sass y CSS. Antes de crear una clase `el-*` nueva, comprobar que no está ya en `_components.scss`; si hay que añadirla, documentarla aquí en el mismo cambio.

---

## 1. Imagen de Marca

**Base estética:** claridad de catálogo. Superficies blancas sobre lienzo gris muy claro, azul de marca reservado a lo accionable, navy para toda la tipografía. El producto vende confianza (los cursos están revisados) y progreso (ves cuánto llevas), así que el diseño prioriza la legibilidad y el estado sobre la decoración.

**Principios:**

- **La portada del curso manda.** En el catálogo, la imagen es el elemento con más peso visual; todo lo demás es soporte.
- **El estado siempre visible.** Publicado, pendiente de revisión, aprobado, comprado, completado: nunca se deducen, se leen.
- **El azul se gana.** Solo lo accionable y lo de marca van en azul; el texto es navy.
- **Aire antes que bordes.** Separar con espacio; el borde de 1px es el último recurso.
- **Una sola familia de iconos** (Font Awesome), un solo acento por pantalla.
- Radios: tarjetas y paneles `12px`, controles `8px`, píldoras `999px`.
- Sombras planas y bajas; nada de elevaciones dramáticas salvo en arrastrar y soltar.

---

## 2. Tokens de Color

Paleta derivada del logotipo (`app/assets/images/logo.png`). Contrastes medidos según WCAG 2.1. Justificación completa en `docs/imagen-de-marca.md` §6.

### Azul de marca

| Token | Hex | Sobre blanco | Uso |
|---|---|---|---|
| `--el-blue-50` | `#edf8fe` | 1.08:1 | Fondo de aviso informativo |
| `--el-blue-100` | `#dbf1fd` | 1.17:1 | Fondo de píldora informativa |
| `--el-blue-200` | `#b4e1fb` | 1.39:1 | Bordes suaves, hover claro |
| `--el-blue-300` | `#83cef9` | 1.73:1 | Texto/enlace **sobre navy** |
| `--el-blue-400` | `#4db9f6` | 2.19:1 | Iconos grandes sobre navy |
| `--el-blue-500` | `#21a8f4` | 2.63:1 | **Color de marca.** Solo superficies y gráficos grandes |
| `--el-blue-600` | `#1a86c3` | 4.01:1 | **Fondo de botón primario** (texto blanco) |
| `--el-blue-700` | `#156c9c` | 5.74:1 | **Texto y enlaces sobre blanco** |
| `--el-blue-800` | `#105175` | 8.55:1 | Titulares de acento |
| `--el-blue-900` | `#0b3953` | 12.18:1 | Máximo contraste |

### Neutros

| Token | Hex | Contraste s/blanco | Uso |
|---|---|---|---|
| `--el-ink` | `#2a4054` | 10.72:1 — AAA | Titulares y texto principal, cabecera, pie |
| `--el-ink-muted` | `#3d566e` | 7.62:1 — AAA | Texto secundario |
| `--el-ink-soft` | `#64748b` | 4.76:1 — AA | Metadatos, etiquetas, deshabilitado |
| `--el-border` | `#e2e8f0` | — | Separadores, bordes de tarjeta |
| `--el-canvas` | `#f6f9fc` | — | Fondo de página |
| `--el-surface` | `#ffffff` | — | Tarjetas, paneles, tablas |
| `--el-on-ink` | `#ebedf0` | 9.14:1 sobre navy | Texto sobre navy |

### Semánticos

| Token | Texto | Fondo | Significado |
|---|---|---|---|
| `--el-success` | `#15803d` | `#ecfdf5` | Lección completada, curso aprobado, pago correcto |
| `--el-warning` | `#b45309` | `#fffbeb` | Pendiente de revisión, borrador |
| `--el-danger` | `#b91c1c` | `#fef2f2` | Error, validación, acción destructiva |
| `--el-info` | `#156c9c` | `#edf8fe` | Publicado, novedad, ayuda |

### Reglas duras

- **`#21a8f4` NUNCA como color de texto sobre blanco** — 2.63:1, falla WCAG AA. Para texto y enlaces sobre blanco: `--el-blue-700` (`#156c9c`).
- **NUNCA** hex sueltos inline (`style="color: #..."`). Todo por token.
- **NUNCA** color nuevo sin añadirlo antes a `docs/imagen-de-marca.md` §6 y a esta tabla.
- **Prohibido el púrpura `#563d7c`** y la clase `.btn-custompurple`: no son de esta marca. Sustituir por botón primario.
- El color nunca es el único portador de significado: todo estado lleva texto o icono.

---

## 3. Tipografía

- **Familia**: la pila por defecto de Bootstrap 5. La aplicación **no carga fuentes propias** hoy; la geométrica para titulares que propone `docs/imagen-de-marca.md` §7 está **sin implementar**, así que titulares y cuerpo se distinguen por **peso y tamaño**, no por familia.
- **Display** (portada): `clamp(2rem, 5vw, 3.25rem)`, weight 800, `letter-spacing: -0.02em`, color `--el-ink` (o `--el-on-ink` sobre fondo oscuro).
- **Título de página** (h1): `clamp(1.5rem, 2.5vw, 2rem)`, weight 700, `-0.02em`.
- **Título de sección** (h2, cabecera de panel): `1.25rem`, weight 600.
- **Título de tarjeta de curso**: `1.05rem`, weight 600, máximo 2 líneas con elipsis.
- **Cuerpo**: `1rem`, line-height `1.6`, color `--el-ink`.
- **Secundario / metadatos**: `0.9rem`, color `--el-ink-muted`.
- **Etiqueta / píldora**: `0.75rem`, weight 600, mayúsculas, `letter-spacing: 0.08em`.

Máximo 75 caracteres por línea en texto largo (descripción de curso, lección).

---

## 4. Espaciado, Bordes y Sombras

| Propiedad | Valor canónico | Aplicación |
|---|---|---|
| Radio tarjeta / panel | `12px` | `.card`, `.el-panel` |
| Radio control | `8px` | inputs, botones, selects |
| Radio píldora | `999px` | `.el-pill` |
| Radio imagen de portada | `12px 12px 0 0` | `.card-img-top` |
| Padding tarjeta | `1rem` | `.card-body` |
| Padding panel | `clamp(1rem, 2vw, 1.5rem)` | `.el-panel` |
| Padding celda tabla | `0.75rem 1rem` | `tbody td` |
| Padding píldora | `0.2rem 0.65rem` | `.el-pill` |
| Hueco de rejilla | `1.25rem` | catálogo de cursos |
| Borde | `1px solid var(--el-border)` | tarjetas, separadores |
| Sombra tarjeta | `0 1px 2px rgba(42, 64, 84, 0.06)` | reposo |
| Sombra tarjeta hover | `0 6px 16px rgba(42, 64, 84, 0.12)` | hover en catálogo |
| Sombra botón primario | `0 2px 8px rgba(26, 134, 195, 0.24)` | `.btn-primary` |
| Foco | `0 0 0 3px rgba(33, 168, 244, 0.35)` | inputs y botones |
| Transición | `160ms ease` | hover/focus |
| Relación de portada | `16:9`, `object-fit: cover` | `.card-img-top` |

---

## 5. Layout

```
body (fondo --el-canvas, texto --el-ink)
├── _header.html.haml           ← navbar navy, logotipo a la izquierda
├── _messages                   ← flash (alertas)
├── .container                  ← contenido de página
│   ├── h1 / cabecera de página
│   ├── .row
│   │   ├── .col-lg-3           ← filtros del catálogo (aside)
│   │   └── .col-lg-9           ← rejilla de cursos
│   └── paginación Pagy
└── _footer
```

- Ancho máximo de contenido: `1200px`, centrado.
- **Catálogo**: rejilla de tarjetas, `col-12 col-sm-6 col-lg-4` (3 por fila en escritorio).
- **Ficha de curso**: 2 columnas en `lg+` — contenido (8) + panel lateral de compra/progreso (4). En móvil el panel lateral sube por encima del temario.
- **Aula (lección)**: vídeo arriba a ancho completo del contenido, temario en columna lateral, comentarios debajo.

---

## 6. Componentes de UI

### 6.1 Tarjeta de curso

Es **el** componente de la marca. Vive en `app/views/courses/_course.html.haml`.

Orden visual obligatorio: **portada → título → profesor → metadatos → precio/acción → estado**.

```haml
.card.el-course-card
  .card-img-top
    = link_to course_path(course) do
      = image_tag course.avatar, alt: course.title
  .card-body
    %h3.el-course-card__title= link_to course.title, course_path(course)
    .el-course-card__teacher
      %i.fa.fa-chalkboard-teacher
      = link_to course.user.username, user_path(course.user)
    .el-course-card__meta
      %span
        %i.fa.fa-star.text-warning
        = course.average_rating
      %span
        %i.fa.fa-user-graduate
        = course.enrollments_count
      %span
        %i.fa.fa-tasks
        = course.lessons_count
  .card-footer
    = enrollment_button(course)
```

- La portada siempre lleva `alt` con el título del curso.
- Los tres metadatos (nota, inscritos, lecciones) van en una sola fila con iconos; si no caben, se ocultan primero las lecciones.
- **Un solo botón principal** por tarjeta. Las acciones de profesor y administrador van en un pie aparte, nunca compitiendo con el botón del estudiante.

### 6.2 Píldoras de estado (`el-pill`)

**REGLA CRÍTICA**: sustituyen a `badge badge-*`, que es **Bootstrap 4 y no existe en Bootstrap 5** — hoy esos badges se renderizan **sin color** (ver §12).

| Clase | Estado del dominio | Color |
|---|---|---|
| `el-pill el-pill--success` | `published`, `approved`, lección completada | Verde |
| `el-pill el-pill--warning` | `unapproved` / esperando revisión | Ámbar |
| `el-pill el-pill--muted` | `unpublished` / borrador | Gris |
| `el-pill el-pill--info` | Etiqueta de curso, idioma, nivel | Azul |
| `el-pill el-pill--danger` | Rechazado | Rojo |

Mapeo estándar, con el texto en inglés (idioma de la interfaz):

- `course.published?` → `--success` "Published" · si no → `--muted` "Draft"
- `course.approved?` → `--success` "Approved" · si no → `--warning` "Waiting for review"

**Anti-patrón:** `badge badge-success` (BS4, muerta) y `badge bg-success` (BS5, válida pero fuera del sistema). Siempre `el-pill`.

### 6.3 Botones

Bootstrap 5 con la paleta de marca aplicada por token.

| Clase | Uso |
|---|---|
| `btn btn-primary` | Acción principal: *Enroll*, *Continue*, *Publish*. Fondo `--el-blue-600`, texto blanco |
| `btn btn-outline-primary` | Acción secundaria. Borde y texto `--el-blue-700` |
| `btn btn-link` | Terciaria; color `--el-blue-700`, subrayado en hover |
| `btn btn-danger` | Solo destructivas, siempre con `turbo_confirm` |
| `btn btn-sm` | Acciones dentro de tarjetas y filas |

- **Un solo `btn-primary` por vista.**
- Todo botón empieza por verbo (`docs/imagen-de-marca.md` §4).
- Icono a la izquierda del texto, con `me-1` (**no `mr-1`**, que es BS4).
- **Prohibida** `.btn-custompurple`.

### 6.4 Paneles (`el-panel`)

```haml
%section.el-panel
  %header.el-panel__head
    %h2 Lessons
  .el-panel__body
    ...
```

Blanco, radio 12px, borde `--el-border`, sombra plana. La cabecera opcional lleva fondo `--el-canvas`.

### 6.5 Progreso del curso

El progreso es una promesa de marca: se muestra siempre que exista inscripción.

```haml
.el-progress
  .progress
    .progress-bar{ style: "width: #{progress}%", role: 'progressbar',
                   'aria-valuenow' => progress, 'aria-valuemin' => 0, 'aria-valuemax' => 100 }
  %span.el-progress__label 4 of 12 lessons done
```

- Barra en `--el-blue-600` sobre `--el-blue-100`, alto `8px`, radio `999px`.
- **Siempre con etiqueta textual** al lado: el color solo no comunica (§2).
- Porcentaje redondeado a entero; el texto usa el recuento, no el porcentaje.

### 6.6 Filtros del catálogo

Columna lateral en escritorio (`col-lg-3`), acordeón plegado en móvil. Un `simple_form` con Ransack.

```haml
%aside.el-filters
  = search_form_for @ransack_courses, as: :courses_search, url: @ransack_path do |f|
    .el-filters__group
      = f.label :title
      = f.search_field :title_cont, class: 'form-control', placeholder: 'Title'
    .el-filters__group
      = f.label :level
      = f.select :level_cont, Course.levels, { include_blank: true }, class: 'form-select'
    = f.submit 'Search', class: 'btn btn-primary w-100'
```

- **Todo campo lleva `label`.** Un `placeholder` no es una etiqueta.
- `form-select` para los desplegables (**no `form-control`**, que es BS4).
- Los filtros activos se muestran como `el-pill--info` descartables sobre la rejilla.

### 6.7 Tablas

`table table-hover align-middle` sobre `el-panel`, fondo blanco, cabecera con fondo `--el-canvas`, texto `--el-ink-soft` en mayúsculas `0.08em`. Numéricos alineados a la derecha con `text-end` (**no `text-right`**, BS4). En móvil, envolver en `.table-responsive`.

### 6.8 Formularios

`simple_form` con envoltorio de Bootstrap 5. Nunca escribir el HTML de un input a mano.

- Texto enriquecido (descripción de curso, contenido de lección): **Trix / Action Text**, con `trix-editor.form-control { height: auto; }`.
- Selección múltiple (etiquetas): **Selectize**, con los tokens repintados a `el-pill--info`.
- Campos anidados (lecciones dentro del asistente): **Cocoon**. El bloque `.nested-fields` usa la sombra de tarjeta de §4 y el resaltado de arrastre va en `--el-blue-200` (**no en púrpura**).
- Errores: mensaje bajo el campo en `--el-danger`, con `aria-describedby`. Los iconos de validación de Bootstrap van desactivados a propósito.

### 6.9 Reproductor de vídeo

Video.js para archivos subidos, incrustado para YouTube. Contenedor `16:9` con `ratio ratio-16x9` de Bootstrap, radio 12px y `overflow: hidden`. Un solo reproductor visible por pantalla.

### 6.10 Alertas (flash)

Bootstrap 5 con la paleta semántica: borde izquierdo de 4px del color de estado sobre el fondo suave de §2.

| Clase | Color |
|---|---|
| `alert-success` | `#15803d` sobre `#ecfdf5` |
| `alert-warning` | `#b45309` sobre `#fffbeb` |
| `alert-danger` | `#b91c1c` sobre `#fef2f2` |
| `alert-info` | `#156c9c` sobre `#edf8fe` |

### 6.11 Paginación (Pagy)

Estilo Bootstrap de Pagy. Página activa con fondo `--el-blue-600` y texto blanco; el resto `--el-blue-700` sobre blanco; deshabilitadas en `--el-ink-soft`.

### 6.13 Asistente de creación (`el-steps`)

Indicador de pasos del asistente de curso. Sustituye a las dos barras `.progress` superpuestas que se pintaban con el mismo ancho y no reflejaban el avance.

```haml
%ol.el-steps
  %li.el-steps__item.el-steps__item--current
    %span.el-steps__index 1
    %span Basic info
  %li.el-steps__item.el-steps__item--done
    %span.el-steps__index
      %i.fa.fa-check
    %span Details
```

| Modificador | Estado |
|---|---|
| (base) | Paso pendiente |
| `--current` | Paso actual: borde azul, fondo `--el-blue-50` y peso, no solo color (§9) |
| `--done` | Paso completado: verde, con icono de comprobación |

### 6.12 Confirmación de borrado

`data: { turbo_confirm: '...' }` sobre el diálogo nativo. El mensaje dice **qué** se borra y que no tiene vuelta atrás: `"Delete “#{course.title}”? This can't be undone."` — nunca un "Are you sure?" pelado.

---

## 7. Iconografía

- **Librería única: Font Awesome 5** (`fa fa-*`, `far fa-*`, `fab fa-*`). Es la que el proyecto ya carga. **No introducir Bootstrap Icons** ni ninguna otra familia.
- Tamaño en botones: `1rem`; en metadatos de tarjeta: `0.9rem`.
- Todo icono decorativo lleva `aria-hidden="true"`; si un icono es la única etiqueta de un control, el control necesita `aria-label`.

| Concepto | Icono |
|---|---|
| Curso / titulación | `fa-graduation-cap` |
| Profesor | `fa-chalkboard-teacher` |
| Estudiante inscrito | `fa-user-graduate` |
| Lecciones | `fa-tasks` |
| Valoración | `fa-star` |
| Buscar | `fa-search` |
| Idioma | `fa-globe-africa` |
| Nivel | `fa-signal` |
| Editar | `fa-edit` |
| Analíticas | `fa-chart-bar` |
| Acceso social | `fab fa-google`, `fab fa-github`, `fab fa-facebook` |

---

## 8. Responsive

Breakpoints de Bootstrap (`sm 576`, `md 768`, `lg 992`, `xl 1200`). Mobile-first.

- Catálogo: 1 columna → 2 en `sm` → 3 en `lg`.
- Filtros: acordeón plegado en móvil, columna lateral fija en `lg+`.
- Ficha de curso: una columna en móvil con el panel de compra **arriba**; dos columnas en `lg+`.
- Tablas: siempre dentro de `.table-responsive`.
- Objetivo táctil mínimo `44×44px`.
- El vídeo mantiene `16:9` en todos los tamaños.

---

## 9. Accesibilidad

No es una sección opcional: la marca promete claridad.

- Contraste mínimo **4.5:1** en texto normal, **3:1** en texto grande (≥24px) y en iconos que porten significado.
- **`#21a8f4` no es color de texto sobre blanco.** Ver §2.
- Foco visible siempre: `0 0 0 3px rgba(33, 168, 244, 0.35)`. Nunca `outline: none` sin sustituto.
- Toda imagen de curso con `alt`; las decorativas con `alt=""`.
- Estado nunca solo por color: acompañar de texto o icono.
- Jerarquía de encabezados sin saltos (un solo `h1` por página).

---

## 10. Antipatrones (NO HACER)

1. **`badge badge-success` / `badge-info` / `badge-danger`** — clases de Bootstrap 4, no existen en BS5, se ven sin color. Usar `el-pill--*`.
2. **`text-right`, `mr-*`, `ml-*`, `pl-*`, `pr-*`** — BS4. En BS5: `text-end`, `me-*`, `ms-*`, `ps-*`, `pe-*`.
3. **`form-control` en un `<select>`** — en BS5 es `form-select`.
4. `#21a8f4` como color de texto sobre blanco.
5. `style="color: #..."` o cualquier hex inline.
6. `.btn-custompurple` o cualquier uso del púrpura `#563d7c`.
7. Mezclar Font Awesome con Bootstrap Icons u otra familia.
8. Más de un `btn-primary` por vista.
9. Imágenes enlazadas a dominios externos (ver §12.5).
10. Barra de progreso sin etiqueta textual.
11. Campos de formulario con `placeholder` pero sin `label`.
12. `turbo_confirm: 'Are you sure?'` sin decir qué se borra.
13. Crear clases `el-*` nuevas sin proponerlas antes.
14. Sombras, radios o espaciados sin referencia a §4.

---

## 11. Checklist de revisión de UI

- [ ] Estados con `el-pill--*`, nunca `badge badge-*`
- [ ] Sin clases de Bootstrap 4 (`text-right`, `mr-*`, `form-control` en selects)
- [ ] Un solo `btn-primary`; todos los botones empiezan por verbo
- [ ] Texto en navy `--el-ink`; enlaces en `--el-blue-700`
- [ ] Contraste verificado (4.5:1 normal, 3:1 grande)
- [ ] Foco visible en todo elemento interactivo
- [ ] Iconos solo de Font Awesome, decorativos con `aria-hidden`
- [ ] Portadas con `alt`, relación 16:9
- [ ] Progreso con etiqueta textual
- [ ] Campos con `label` real
- [ ] Probado en móvil y escritorio
- [ ] Sin hex inline; todo por token de §2
- [ ] Textos en **inglés** (idioma de la interfaz)

---

## 12. Estado de la migración

Cerrado en la pasada de rediseño:

1. ✅ **Tokens en SCSS**: `_brand.scss` define la paleta y sobrescribe las variables de Bootstrap antes de importarlo, así que botones, enlaces, alertas y formularios salen ya con la marca. `_components.scss` implementa las clases `el-*` y expone los tokens como variables CSS.
2. ✅ **Esquema invertido**: el `body` pasa de navy a `--el-canvas`; el navy queda para cabecera, pie y tipografía.
3. ✅ **Púrpura `#563d7c` eliminado**, junto con `.btn-custompurple` y `.purple-background`.
4. ✅ **Clases de Bootstrap 4 retiradas de las vistas**: `badge-*`, `text-right`, `float-*`, `mr-*`/`ml-*`, `form-inline`, `input-group-append`, `card-columns`, `font-weight-bold`, `.close`.
5. ✅ **Imagen de portada local** (`home-photo.jpg` vía Propshaft) en lugar del dominio externo.
6. ✅ **Regla huérfana** `.element { color: green }` eliminada.
7. ✅ **Hojas por controlador vacías** eliminadas; el CSS vive en `_brand.scss` + `_components.scss`.
8. ✅ **Logotipo corregido**: favicon y certificado usan el logotipo real.

Corregido además, por bloquear la propia interfaz:

- **`data-bs-*`**: los desplegables, el botón hamburguesa y el cierre de alertas usaban los `data-*` de Bootstrap 4 y **no funcionaban**.
- **`<!DOCTYPE html>`**: faltaba en el layout, así que el navegador renderizaba en *quirks mode*.

Pendiente (decisión de producto, no de código):

- La familia geométrica para titulares (`docs/imagen-de-marca.md` §7) sigue **sin implementar**: haría falta cargar la fuente. Hoy titulares y cuerpo comparten familia y se distinguen por peso y tamaño.

---

## 13. Referencias cruzadas

- **Identidad de marca**: `docs/imagen-de-marca.md`
- Tokens de marca y overrides de Bootstrap: `app/assets/stylesheets/_brand.scss`
- Componentes `el-*`: `app/assets/stylesheets/_components.scss`
- Manifiesto de estilos: `app/assets/stylesheets/application.scss`
- Estilos de los PDF: `app/assets/stylesheets/pdf.scss`
- Logotipo: `app/assets/images/logo.png`
- Cabecera: `app/views/layouts/_header.html.haml`
- Portada: `app/views/static_pages/landing_page.html.haml`
- Tarjeta de curso: `app/views/courses/_course.html.haml`
- Certificado: `app/views/enrollments/certificate.pdf.haml`
