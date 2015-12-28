AppView = require 'app/views/app_view'
Draw = require "draw/draw"

module.exports = class Index extends AppView

  destroy:=>
    @ctx?.clear()
    @ctx?.destroy()
    super

  after_render:=>
    setTimeout @init, 1500

  init:=>

    @ctx?.clear()
    @ctx?.destroy()

    @ctx = window.Sketch.create

      container: @el.find(".neural").get(0)

      resize:->
        @draw()

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

      update:->

      mouseup:->

      draw:->

