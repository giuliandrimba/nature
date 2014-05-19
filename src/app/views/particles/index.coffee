AppView = require 'app/views/app_view'
System = require "./system"
Draw = require "draw/draw"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    @ctx = window.Sketch.create

      systems: []
      system: {}

      container:@el.get(0)

      autoclear:true

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

      update:->

      draw:->

        for s in @systems
          s.run()

      mousedown:->

        s = new System x:@mouse.x, y:@mouse.y
        @systems.push s

