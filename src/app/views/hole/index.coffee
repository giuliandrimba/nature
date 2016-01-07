AppView = require 'app/views/app_view'
System = require "./system"
Draw = require "draw/draw"
Pivot = require "./pivot"

module.exports = class Index extends AppView

  title: "Nature : Spiral Hypnosis"

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>
    @ctx = window.Sketch.create

      systems: []
      system: {}
      pivot: {}

      container:@el.find(".lab").get(0)

      autoclear:true

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        target = (x:@width / 2, y:@height / 2)
        @pivot = new Pivot target
        @count = 20

      resize:->
        @update()

      mousemove:->
        @pivot.target = @mouse

      update:->

        @pivot.update()

        if @systems.length < 30

          i = @systems.length

          p = @pivot

          if @systems.length > 0
            p = @systems[i - 1].pivot
            speed = p.speed

          s = new System x:@pivot.x, y:@pivot.y, follows:p, rad: @count
          s.mag += 0.5
          s.setup()
          @systems.push s
          @count += 10

      draw:->

        @pivot.draw()

        i = @systems.length - 1

        while i >= 0

          s = @systems[i]

          s.run()

          i--

