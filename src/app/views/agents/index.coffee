AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Path = require "./path"
Agent = require "./agent"
Vector = require "./vector"
Circle = require "draw/geom/circle"

module.exports = class Index extends AppView

  interval: undefined

  destroy:=>
    clearTimeout @interval
    @ctx?.clear()
    @ctx?.destroy()
    super

  after_render:=>
    @interval = setTimeout @init, 1500

  init:=>

    @ctx = window.Sketch.create

      container:@el.find(".agents").get(0)
      fullscreen: true

      dragging: false

      autoclear:true

      path: {}
      agent: {}
      agents: []

      drag_amount: 0

      old_mouse_x: 0

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

        while i < 150

          r = Math.round(Math.random() * 255);
          g = Math.round(Math.random() * 255);
          b = Math.round(Math.random() * 255);
          a = 1

          a = new Agent 2, "rgba(255, 255, 255, 1)"
          a.x = Math.random() * @width
          a.y = Math.random() * @height

          @agents.push a

          i++

      resize:->
        @draw()

      create_path:->
        i = 0
        steps = 360 / 20

        @spiral_radius = 10

        while i < 1940

          rad = Calc.deg2rad i
          x = @width / 2 + (Math.cos(rad) * @spiral_radius)
          y = @height / 2 + (Math.sin(rad) * @spiral_radius)

          @path.add_point x, y, i
          @spiral_radius += @radius_amout
          i += steps

      calc_spiral_radius:->

        steps = 360 / 50
        @spiral_radius = 25

        for p, i in @path.points

          rad = Calc.deg2rad p.ang
          x = @width / 2 + (Math.cos(rad) * @spiral_radius)
          y = @height / 2 + (Math.sin(rad) * @spiral_radius)

          c = @path.keypoints[i]

          p.x = x
          p.y = y

          c.x = x
          c.y = y

          @spiral_radius += @radius_amout

      mousedown:->

        @old_mouse_x = @mouse.x

        @path.mousedown()
        @dragging = true

      mouseup:->

        @path.mouseup()

      mousemove:->

        @drag_amount = @old_mouse_x - @mouse.x

        @old_mouse_x = @mouse.x

        if @dragging

          @radius_amout -= (@drag_amount * 0.01)


      update:->

        @calc_spiral_radius()
        @path.update @mouse, @dragging, @spiral_radius

        for a in @agents
          a.update()
          a.avoid @agents
          a.follow @path


      draw:->

        @path.draw()

        for a in @agents
          a.draw()

