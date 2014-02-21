AppView = require 'app/views/app_view'
Ball = require "./ball"

module.exports = class Index extends AppView

  after_render:=>

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d");
        
        

      update:->

      draw:->