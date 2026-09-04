// Punto de entrada del bundle de esbuild -> app/assets/builds/application.js
//
// Aquí no se importa CSS a propósito: todas las hojas de estilo pasan por Sass
// (app/assets/stylesheets/application.scss). Si esbuild emitiera CSS, su salida
// se llamaría también application.css y pisaría la de Sass.

import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "./channels"

ActiveStorage.start()

import "bootstrap"
import "./youtube"
import "trix"
import "@rails/actiontext"

import Chartkick from "chartkick"
import * as Chart from "chart.js"
Chartkick.use(Chart)

import jQuery from "jquery"
window.jQuery = jQuery
window.$ = jQuery

// rails-ujs ya no está en el bundle, así que nadie añade el token CSRF a las
// peticiones de jQuery: hay que ponerlo aquí. Sin él Rails las trata como no
// autenticadas, y eso dejaba sin efecto el reordenado de lecciones por
// arrastre y el alta de etiquetas del asistente. Se lee en cada petición
// porque Turbo reemplaza la meta en cada navegación.
jQuery.ajaxSetup({
  beforeSend: function (xhr) {
    const token = document.querySelector('meta[name="csrf-token"]')
    if (token) { xhr.setRequestHeader("X-CSRF-Token", token.content) }
  }
})
import "jquery-ui-dist/jquery-ui"

import videojs from "video.js"

import "./trix-editor-overrides"
import "selectize"
import "cocoon-js"

// Turbo sustituye a Turbolinks: el evento equivalente a turbolinks:load es
// turbo:load, y se dispara igual en la carga inicial y en cada navegación.
document.addEventListener("turbo:load", function () {
  $('.lesson-sortable').sortable({
    cursor: "grabbing",
    cursorAt: { left: 10 },
    placeholder: "ui-state-highlight",
    update: function(e, ui){
      let item = ui.item;
      let item_data = item.data();
      let params = {_method: 'put'};
      params[item_data.modelName] = { row_order_position: item.index() }
      $.ajax({
        type: 'POST',
        url: item_data.updateUrl,
        dataType: 'json',
        data: params
      });
    },
    stop: function(e, ui){
      console.log("stop called when finishing sort of cards");
    }
  });

  $("video").bind("contextmenu", function(){
    return false;
  });

  if ($('.selectize').length){
    $('.selectize').selectize({
      sortField: 'text'
    });
  }

  $(".selectize-tags").selectize({
    create: function(input, callback) {
      $.post('/tags.json', { tag: { name: input } })
        .done(function(response){
          // Sin id no hay etiqueta que seleccionar: se llama a callback() sin
          // argumentos, que es como selectize cancela la creación. Antes se le
          // pasaba {value: undefined} y ese "undefined" viajaba en tag_ids.
          if (response && response.id) {
            callback({value: response.id, text: response.name });
          } else {
            callback();
          }
        })
        .fail(function(){
          callback();
        })
    }
  });

  // Antes se llamaba a videojs() sin comprobar nada: en cualquier página sin
  // reproductor, getElementById devuelve null y video.js lanzaba una excepción
  // que abortaba el resto del callback.
  const videoElement = document.getElementById('my-video')

  if (videoElement) {
    let videoPlayer = videojs(videoElement, {
      controls: true,
      playbackRates: [0.5, 1, 1.5],
      autoplay: false,
      fluid: true,
      preload: false,
      liveui: true,
      responsive: true,
      loop: false,
    })
    videoPlayer.addClass('video-js')
    videoPlayer.addClass('vjs-big-play-centered')
  }
});
