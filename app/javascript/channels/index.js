// Antes esto usaba require.context(), una API exclusiva de webpack que esbuild
// no implementa, para cargar automáticamente todos los *_channel.js. Con un
// empaquetador estándar cada canal se importa de forma explícita.
//
// Ahora mismo el proyecto no define ningún canal; se deja preparado el
// consumidor para cuando se añada el primero.
import "./consumer"
