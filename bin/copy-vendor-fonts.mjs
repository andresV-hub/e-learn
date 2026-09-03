// Copia a app/assets/fonts los ficheros de fuente de FontAwesome, cuyo CSS los
// referencia con rutas relativas.
//
// El CSS compilado acaba en app/assets/builds/application.css y Propshaft lo
// sirve bajo /assets/. Al dejar las fuentes en app/assets/fonts su ruta lógica
// ("fa-solid-900.woff2") coincide con la que pide el CSS, y Propshaft reescribe
// cada url() a su versión con digest. Sass no resuelve nada: copia las url()
// tal cual las encuentra.
//
// video.js no aparece aquí porque incrusta sus iconos como data URI.
import { cpSync, mkdirSync, rmSync } from 'node:fs'

const FROM = 'node_modules/@fortawesome/fontawesome-free/webfonts'
const TO = 'app/assets/fonts'

rmSync(TO, { recursive: true, force: true })
mkdirSync(TO, { recursive: true })
cpSync(FROM, TO, { recursive: true })

console.log(`fuentes copiadas: ${FROM} -> ${TO}`)
