AppView = require 'app/views/app_view'
Draw = require "draw/draw"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    @ctx = window.Sketch.create

      container:@el.get(0)

      autoclear:true

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

      mousemove:->

      update:->

      draw:->

