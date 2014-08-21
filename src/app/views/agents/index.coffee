AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Bound = require "./bound"
Agent = require "./agent"
Vector = require "./vector"
Circle = require "draw/geom/circle"

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
      agents: []

      start: {}
      end: {}

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

        @_w = 800
        @_h = 350
        @_x = @width / 2 - (@_w / 2)
        @_y = @height / 2 - (@_h / 2) - 30

        @path = new Bound @_w + 2, 30, "#000"
        @create_path()

        i = 0

        while i < 1

          a = new Agent 5, "#fff"
          a.x = Math.random() * @width
          a.y = Math.random() * @height

          @agents.push a

          i++

      create_path:->
        i = 0
        steps = 360 / 10

        while i < 360
          rad = Calc.deg2rad i
          x = @width / 2 + (Math.cos(rad) * 300)
          y = @height / 2 + (Math.sin(rad) * 300)

          @path.add_point x, y, i
          i += steps

        rad = Calc.deg2rad 0
        x = @width / 2 + (Math.cos(rad) * 300)
        y = @height / 2 + (Math.sin(rad) * 300)

        @path.add_point x, y

      mousemove:->

      update:->

        for a in @agents
          a.update()
          a.follow @path


      draw:->

        @path.draw()

        for a in @agents
          a.draw()

