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

        i = @systems.length - 1

        while i >= 0

          s = @systems[i]

          s.run()

          if s.is_dead()

            @systems.splice i, 1

          i--

      mousedown:->

        s = new System x:@mouse.x, y:@mouse.y
        @systems.push s

