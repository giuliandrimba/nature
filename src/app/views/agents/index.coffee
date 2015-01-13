AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Path = require "./path"
Agent = require "./agent"
Vector = require "./vector"
Circle = require "draw/geom/circle"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    _height = $(window).height()

    @ctx = window.Sketch.create

      container:@el.get(0)
      fullscreen: false
      width: 1200
      height: _height

      dragging: false

      autoclear:true

      path: {}
      agent: {}
      agents: []

      start: {}
      end: {}

      radius_amout: 3

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

        @_w = 800
        @_h = 350
        @_x = @width / 2 - (@_w / 2)
        @_y = @height / 2 - (@_h / 2) - 30

        @path = new Path @_w + 2, 30, "#000"

        _X = @width / 2
        _Y = @height / 2

        @create_path()

        i = 0

        while i < 100

          r = Math.round(Math.random() * 255);
          g = Math.round(Math.random() * 255);
          b = Math.round(Math.random() * 255);
          a = 1

          a = new Agent 2, "rgba(255, 255, 255, 1)"
          a.x = Math.random() * @width
          a.y = Math.random() * @height

          @agents.push a

          i++

      create_path:->
        i = 0
        steps = 360 / 20

        @spiral_radius = 25

        while i < 970

          rad = Calc.deg2rad i
          x = @width / 2 + (Math.cos(rad) * @spiral_radius)
          y = @height / 2 + (Math.sin(rad) * @spiral_radius)

          @path.add_point x, y, i
          @spiral_radius += @radius_amout
          i += steps

      calc_spiral_radius:=>

        i = 0
        steps = 360 / 20

        @spiral_radius = 25

        while i < 970

          rad = Calc.deg2rad i
          x = @width / 2 + (Math.cos(rad) * @spiral_radius)
          y = @height / 2 + (Math.sin(rad) * @spiral_radius)

          @spiral_radius += @radius_amout
          i += steps

      mousedown:->

        @path.mousedown()
        @dragging = true

      mouseup:->

        @path.mouseup()

      mousemove:->

        if @dragging

          dist = Calc.dist @mouse.x, @mouse.y, @width / 2, @height / 2

          @radius_amout = dist * 0.1


      update:->

        @path.update @mouse, @spiral_radius

        for a in @agents
          a.update()
          a.avoid @agents
          a.follow @path


      draw:->

        @path.draw()

        for a in @agents
          a.draw()

