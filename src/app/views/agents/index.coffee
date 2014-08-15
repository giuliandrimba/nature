AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Bound = require "./bound"
Agent = require "./agent"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    @ctx = window.Sketch.create

      container:@el.get(0)

      autoclear:true

      bound: {}
      path: {}
      agent: {}

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

        @_w = 800
        @_h = 350
        @_x = @width / 2 - (@_w / 2)
        @_y = @height / 2 - (@_h / 2) - 30

        @bound = new Bound @_x, @_y, @_w, @_h
        @path = new Bound @_x - 1, (@_y + (@_h / 2 - 15)), @_w + 2, 30, "#000"

        @agent = new Agent 5, "000"

        @agent.x = @bound.x + 100
        @agent.y = @bound.y + 100

        @path_distance()

      mousemove:->

      update:->

        # @agent.update()

      draw:->

        @bound.draw()
        @path.draw()
        @agent.draw()

      normalize:(vec)->

      path_distance:->

        a =
          x1: @path.x
          y1: @path.y
          x2: @agent.next_pos().x
          y2: @agent.next_pos().y
          x: 0
          y: 0

        b =
          x1: @path.x + @path.w
          y1: @path.y
          x2: 0
          y2: 0

        a.mag = Calc.dist a.x, a.y, @path.x, @path.y
        b.mag = Calc.dist a.x, a.y, @path.x, @path.y

        theta = Calc.deg2rad(Calc.ang a.x, a.y, b.x, b.y)

        d = a.mag * Math.cos(theta)

        console.log d

