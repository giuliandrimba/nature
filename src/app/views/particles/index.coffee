AppView = require 'app/views/app_view'
System = require "./system"
Draw = require "draw/draw"
Pivot = require "./pivot"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    @ctx = window.Sketch.create

      systems: []
      system: {}
      pivot: {}

      container:@el.get(0)

      autoclear:true

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        target = (x:@width / 2, y:@height / 2)
        @pivot = new Pivot target

      mousemove:->
        @pivot.target = @mouse

      update:->

        @pivot.update()

        s = new System x:@pivot.x, y:@pivot.y, mouse:@mouse
        @systems.push s

      draw:->

        @pivot.draw()

        i = @systems.length - 1

        while i >= 0

          s = @systems[i]

          s.run()

          if s.is_dead()

            @systems.splice i, 1

          i--

      mouseup:->

        @down = false

      mousedown:->

        @down = true

