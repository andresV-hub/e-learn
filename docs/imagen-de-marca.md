# Imagen de marca — E-Learn

> Documento de identidad de marca. Describe **qué es E-Learn, a quién habla y cómo debe verse y sonar**.
> La traducción de esta identidad a tokens, clases y componentes concretos vive en
> `.claude/skills/rails-frontend-design/references/styles.md`, que se deriva de este documento.
>
> Los valores de color no son inventados: se han muestreado del logotipo real
> (`app/assets/images/logo.png`) y sus contrastes están medidos según WCAG 2.1.

---

## 1. Qué es E-Learn

E-Learn es un **marketplace de formación online**. No es una academia con catálogo
cerrado ni una herramienta interna de RRHH: es una plaza donde cualquiera puede
publicar un curso y cualquiera puede comprarlo y seguirlo.

El producto se sostiene sobre tres verbos, en este orden:

1. **Descubrir** — catálogo con buscador, etiquetas, valoraciones, cursos destacados por novedad, popularidad y nota media.
2. **Aprender** — lecciones con vídeo, texto enriquecido, progreso por lección, comentarios y certificado al terminar.
3. **Enseñar** — cualquier usuario puede crear un curso mediante un asistente por pasos, subir lecciones, ordenarlas y ver analíticas de sus ventas.

Sobre esos tres verbos hay una capa de **confianza**: un administrador revisa y
aprueba los cursos antes de que aparezcan en el catálogo público. Esa revisión no
es un detalle técnico, es una promesa de marca.

### Lo que el producto ya hace (base fáctica de esta identidad)

| Área | Capacidades reales en el código |
|---|---|
| Catálogo | Búsqueda por título (Ransack), etiquetas, filtros, paginación, destacados por `latest` / `popular` / `top_rated` |
| Curso | Portada, descripción enriquecida, idioma (6), nivel (4), precio, nota media, contador de inscripciones y lecciones |
| Aprendizaje | Lecciones ordenables, vídeo (Video.js y YouTube), progreso por lección, comentarios |
| Reputación | Valoración de 1 a 5 y reseña escrita por inscripción; la nota media del curso se recalcula sola |
| Acreditación | Certificado descargable en PDF al completar |
| Enseñanza | Asistente de creación por pasos, analíticas de ventas del profesor |
| Gobierno | Aprobación de cursos por administrador, panel de analíticas global, actividad registrada |
| Acceso | Registro propio y acceso con Google, GitHub y Facebook |

Toda decisión visual debe poder justificarse contra esta tabla. Si un elemento de
diseño no sirve a descubrir, aprender, enseñar o generar confianza, sobra.

---

## 2. Posicionamiento

> **E-Learn es la puerta abierta al aprendizaje: catálogo abierto, precio claro y un profesor de verdad al otro lado.**

**Promesa:** empiezas a aprender hoy, sin fricción y sabiendo exactamente qué compras.

**Lo que nos diferencia**, y que el diseño debe hacer evidente:

- **Doble rol sin muros.** El mismo usuario que compra puede publicar. La interfaz nunca debe hacer sentir que enseñar es un privilegio reservado.
- **Catálogo revisado.** Todo curso visible ha pasado una aprobación. Es el argumento contra la sensación de "granero de vídeos".
- **Progreso visible.** El avance lección a lección y el certificado final son la recompensa; deben verse, no esconderse en un submenú.

**Lo que NO somos:** una plataforma corporativa de cumplimiento normativo, una red
social, ni una app de gamificación con rachas y medallas. Nada de confeti.

---

## 3. Públicos

La interfaz sirve a tres personas con necesidades opuestas. El diseño debe
resolver las tres sin fragmentar la marca.

| Público | Qué viene a hacer | Qué necesita ver primero | Riesgo si fallamos |
|---|---|---|---|
| **Estudiante** | Encontrar un curso y avanzar | Buscador, precio, nivel, idioma, nota media, "dónde lo dejé" | Se va al catálogo de otro |
| **Profesor** | Publicar y vender | Estado del curso (borrador / pendiente / publicado), lecciones, ingresos | Abandona la creación a medias |
| **Administrador** | Mantener la calidad | Cola de cursos por aprobar, métricas globales | El catálogo se degrada |

**Regla de jerarquía:** cuando una pantalla sirve a varios roles, manda el
estudiante. Las herramientas de profesor y administrador son accesibles, no
protagonistas.

---

## 4. Personalidad y voz

**Personalidad:** cercana, clara y competente. Un buen profesor explicando algo por
primera vez: te trata de tú, no te trata de tonto.

Cuatro ejes, de más a menos:

- **Claro** antes que ingenioso. Si hay que elegir entre una palabra exacta y una graciosa, gana la exacta.
- **Alentador** sin ser efusivo. Celebramos el progreso una vez y seguimos.
- **Honesto** con el dinero y el esfuerzo. El precio, el nivel y la duración se dicen de frente.
- **Humano.** Detrás de cada curso hay una persona con nombre; el diseño la muestra.

### Idioma

**La interfaz de E-Learn está en inglés** (`"What do you want to learn today?"`),
aunque la documentación del proyecto esté en español. Los ejemplos de voz de esta
sección van en inglés porque es el idioma que ve el usuario. Si algún día se
traduce la interfaz, esta sección se reescribe; hasta entonces, **no se mezclan
idiomas en pantalla**.

### Cómo escribimos

| Situación | Sí | No |
|---|---|---|
| Invitación | "What do you want to learn today?" | "Unlock your potential today!" |
| Botón principal | "Start learning", "Publish course" | "Submit", "OK" |
| Curso pendiente | "Waiting for review" | "Not approved" |
| Error de pago | "We couldn't process the payment. Your card was not charged." | "Transaction failed. Error 402." |
| Sin resultados | "No courses match that search yet. Try a broader term." | "Empty." |
| Progreso | "4 of 12 lessons done" | "33.33% complete" |

**Reglas duras de microcopia:**

- Los botones empiezan por verbo: *Enroll*, *Continue*, *Publish*.
- El estado se nombra desde el usuario, no desde la base de datos: *Waiting for review*, no *approved: false*.
- Nunca culpar al usuario en un error; decir qué ha pasado y qué puede hacer.
- Los porcentajes se redondean a entero; los contadores se escriben en palabras cuando son pequeños.

---

## 5. Logotipo

El logotipo es un **birrete de graduación** sobre el wordmark **E-LEARN** en
mayúsculas, sans-serif geométrica de peso extrabold.

**Fichero canónico:** `app/assets/images/logo.png` (300×220 px, PNG con transparencia).

Colores muestreados del propio fichero:

| Elemento | Color | Nota |
|---|---|---|
| Birrete | `#21a8f4` | Azul de marca, el elemento con más presencia (40% de los píxeles opacos) |
| Wordmark "E-LEARN" | `#5cb9d8` | Turquesa, un paso más apagado y frío que el birrete |

### Usos

- **Espacio de respeto:** como mínimo la altura del birrete a cada lado.
- **Tamaño mínimo:** 32 px de alto para el conjunto; por debajo, usar solo el birrete.
- **Sobre fondo oscuro** (`#2a4054`): versión tal cual, el azul contrasta 4.07:1 — suficiente para un elemento gráfico grande.
- **Sobre fondo claro**: tal cual; nunca añadirle sombras ni contornos.

### Prohibido

1. Recolorear el birrete a un color fuera de la paleta.
2. Estirarlo sin mantener proporción, rotarlo o inclinarlo.
3. Ponerlo sobre una fotografía sin una capa de contraste debajo.
4. Reconstruir el wordmark con otra tipografía.
5. **Usar `logo_blue.png` como logotipo** — ver §10.

---

## 6. Color

La paleta nace del logotipo. El azul del birrete manda; el navy que la aplicación
ya usa como fondo se promueve a color de tinta.

### 6.1 Azul de marca (escala)

Derivada de `#21a8f4`. Los ratios están medidos contra blanco y contra el navy.

| Tono | Hex | Sobre blanco | Sobre navy | Uso |
|---|---|---|---|---|
| 50 | `#edf8fe` | 1.08:1 | 9.93:1 | Fondo de aviso informativo |
| 100 | `#dbf1fd` | 1.17:1 | 9.19:1 | Fondo de píldora informativa |
| 200 | `#b4e1fb` | 1.39:1 | 7.71:1 | Bordes suaves, estados hover claros |
| 300 | `#83cef9` | 1.73:1 | 6.21:1 | Texto y enlaces **sobre navy** |
| 400 | `#4db9f6` | 2.19:1 | 4.89:1 | Texto sobre navy, iconos grandes |
| **500** | **`#21a8f4`** | 2.63:1 | 4.07:1 | **Color de marca.** Solo superficies y gráficos grandes |
| 600 | `#1a86c3` | 4.01:1 | 2.67:1 | Fondo de botón primario (con texto blanco) |
| **700** | **`#156c9c`** | 5.74:1 | 1.87:1 | **Texto y enlaces sobre blanco** |
| 800 | `#105175` | 8.55:1 | 1.25:1 | Titulares de acento |
| 900 | `#0b3953` | 12.18:1 | 1.14:1 | Máximo contraste |

> **La regla más importante de esta paleta:** `#21a8f4` **no vale para texto sobre
> blanco** (2.63:1, por debajo del mínimo 4.5:1 de WCAG AA). Es un color de
> superficie. Para texto y enlaces sobre blanco se usa el **700 `#156c9c`**.

### 6.2 Neutros

| Rol | Hex | Contraste sobre blanco | Uso |
|---|---|---|---|
| **Navy (tinta)** | `#2a4054` | 10.72:1 — AAA | Titulares, texto principal, cabecera y pie |
| Tinta media | `#3d566e` | 7.62:1 — AAA | Texto secundario |
| Tinta suave | `#64748b` | 4.76:1 — AA | Etiquetas, metadatos, texto deshabilitado |
| Borde | `#e2e8f0` | — | Separadores, bordes de tarjeta |
| Lienzo | `#f6f9fc` | — | Fondo de página |
| Superficie | `#ffffff` | — | Tarjetas, paneles, tablas |
| Texto sobre navy | `#ebedf0` | 9.14:1 sobre navy — AAA | Texto en zonas oscuras |

### 6.3 Semánticos

Cada estado tiene un tono de texto (accesible sobre blanco) y un fondo suave.

| Estado | Texto | Fondo | Contraste | Significado en E-Learn |
|---|---|---|---|---|
| **Éxito** | `#15803d` | `#ecfdf5` | 5.02:1 — AA | Lección completada, curso aprobado, pago correcto |
| **Aviso** | `#b45309` | `#fffbeb` | 5.02:1 — AA | Pendiente de revisión, borrador sin publicar |
| **Error** | `#b91c1c` | `#fef2f2` | 6.47:1 — AA | Pago fallido, validación, acción destructiva |
| **Informativo** | `#156c9c` | `#edf8fe` | 5.74:1 — AA | Publicado, novedad, ayuda |

### 6.4 Reglas de color

1. **Sin color nuevo sin añadirlo antes a este documento.** Nada de verdes lima ni púrpuras sueltos.
2. **Fuera el púrpura `#563d7c`.** Es el púrpura de la documentación de Bootstrap, no de E-Learn; hoy aparece en `.btn-custompurple` y en el resaltado de arrastrar y soltar. Se sustituye por azul 600.
3. **El azul de marca no se usa para texto pequeño sobre blanco.** Ver §6.1.
4. **Nada de color inline** (`style="color: #..."`). Todo pasa por token.
5. **El color nunca es el único portador de significado**: un estado lleva siempre texto o icono además del color.
6. **Máximo un acento por pantalla.** Si todo destaca, nada destaca.

---

## 7. Tipografía

El wordmark del logotipo es una **sans-serif geométrica extrabold**. La tipografía
de interfaz debe acompañarla sin competir con ella.

**Titulares:** geométrica de peso alto (Poppins o Montserrat, 600–800) — es la
familia que armoniza con el wordmark.
**Cuerpo:** pila del sistema, por velocidad y legibilidad:

```
system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif
```

> **Estado actual:** la aplicación **no carga ninguna fuente propia**; usa la pila
> por defecto de Bootstrap 5 en toda la interfaz. La familia de titulares de arriba
> es una **recomendación no implementada**. Adoptarla exige cargar la fuente y
> actualizar `styles.md`; mientras no se haga, titulares y cuerpo comparten familia
> y se distinguen solo por peso y tamaño.

| Nivel | Tamaño | Peso | Uso |
|---|---|---|---|
| Display | `clamp(2rem, 5vw, 3.25rem)` | 800 | Reclamo de la portada |
| Título de página | `clamp(1.5rem, 2.5vw, 2rem)` | 700 | H1 |
| Título de sección | `1.25rem` | 600 | H2, cabeceras de panel |
| Título de tarjeta | `1.05rem` | 600 | Nombre de curso en el catálogo |
| Cuerpo | `1rem` / `1.6` | 400 | Texto general |
| Secundario | `0.9rem` | 400 | Metadatos, descripciones cortas |
| Etiqueta | `0.75rem` | 600, `0.08em`, mayúsculas | Nivel, idioma, estado |

Titulares con `letter-spacing: -0.02em`; etiquetas en mayúsculas con `+0.08em`.
Longitud de línea máxima de 75 caracteres en texto largo.

---

## 8. Iconografía e imagen

### Iconos

**Librería única: Font Awesome** (`fa fa-*`), que es la que el proyecto ya carga
(sólidos, regulares y marcas). **No introducir Bootstrap Icons ni ninguna otra**:
mezclar dos familias es el error de coherencia más visible y más barato de evitar.

Vocabulario ya en uso, que se respeta:

| Concepto | Icono |
|---|---|
| Curso / titulación | `fa-graduation-cap` |
| Profesor | `fa-chalkboard-teacher` |
| Buscar | `fa-search` |
| Acceso social | `fab fa-google`, `fab fa-github`, `fab fa-facebook` |

### Fotografía

Las portadas de curso son **subidas por los profesores** (PNG o JPEG, máximo 500 KB),
así que la marca no controla su contenido. Lo que sí controla es el marco:

- Relación fija **16:9**, recorte centrado, esquinas redondeadas del sistema.
- Marcador de posición con el birrete sobre azul 100 cuando no hay portada.
- Ninguna portada lleva texto superpuesto sin capa de contraste.

**Regla:** las imágenes de la interfaz se sirven **desde la propia aplicación**,
nunca enlazadas a un dominio externo (ver §10).

---

## 9. Aplicaciones

### Certificado (PDF)

Es la pieza de marca más importante: el usuario la descarga, la guarda y la
enseña. Debe llevar el **logotipo real**, el nombre del alumno, el del curso, el
del profesor y la fecha. Tipografía de titulares, navy sobre blanco, sin fondos
oscuros que arruinen la impresión.

### Correo

Cabecera con el logotipo sobre blanco, cuerpo en navy, un único botón primario
en azul 600 con texto blanco. Nada de fondos oscuros: muchos clientes de correo
los rompen.

### Favicon

El birrete solo, recortado, sobre transparente.

---

## 10. Estado de aplicación de la marca

Los hallazgos que motivaron este documento se han corregido en la pasada de
rediseño. Se dejan listados porque explican decisiones del sistema actual.

| # | Problema | Estado |
|---|---|---|
| 1 | `logo_blue.png` no es un logotipo: es una taza de café con los nodos de edición vectorial visibles | ✅ Retirado de todo uso |
| 2 | Ese borrador era el **favicon** de la aplicación | ✅ Sustituido por `favicon.png` (el birrete, que ya existía sin usar) |
| 3 | Ese borrador iba impreso en el **certificado** | ✅ Ahora lleva `logo.png` y la paleta de marca |
| 4 | `favicon.png` existía pero no se usaba | ✅ Es el favicon |
| 5 | La portada se servía enlazada a `b2.eu.icdn.ru` | ✅ Usa `home-photo.jpg` local, servido por Propshaft con digest |
| 6 | Paleta real distinta de la de marca (`#2a4054` de fondo, púrpura `#563d7c`, `.element { color: green }`) | ✅ Sustituida por los tokens de §6 |
| 7 | El azul de marca se usaba sin comprobar contraste | ✅ El 500 queda para superficies; el texto usa el 700 |
| 8 | Hojas por controlador vacías, CSS sin sistema | ✅ `_brand.scss` + `_components.scss` |
| 9 | Estados de curso sin color: las vistas usaban `badge-*` de Bootstrap 4 | ✅ Migrado a `el-pill` |

Se corrigieron además dos fallos que impedían ver la marca siquiera:

- **Faltaba el `<!DOCTYPE html>`**, así que el navegador renderizaba en *quirks mode*.
- Los desplegables, el menú hamburguesa y el cierre de alertas usaban los
  atributos `data-*` de Bootstrap 4 y **no funcionaban** con la 5.

Queda una decisión abierta: la **familia geométrica para titulares** de §7 sigue
sin implementar, porque exige cargar una fuente. Hoy titulares y cuerpo comparten
la pila del sistema y se distinguen por peso y tamaño.

---

## 11. Referencias

- Sistema de diseño derivado de este documento: `.claude/skills/rails-frontend-design/references/styles.md`
- Hoja de estilos actual: `app/assets/stylesheets/application.scss`
- Logotipo: `app/assets/images/logo.png`
- Cabecera: `app/views/layouts/_header.html.haml`
- Portada: `app/views/static_pages/landing_page.html.haml`
