AppView = require 'app/views/app_view'
Ball = require "./ball"
Magnet = require "./magnet"
Target = require "./target"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  magnets: []
  started: true

  destroy:->
    @ctx.clear()
    @ctx.destroy()
    @ctx = null
    @magnets = []
    $("body").css "cursor":"default"
    super

  after_render:=>


    _ = @

    _.magnets = []

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        _.ball = new Ball 5, "#000"
        _.ball.x = 50
        _.ball.y = @height / 2

        i = 0

        while i < parseInt($(window).width() / 15)
        # while i < 1

          m = new Magnet 5 + (Math.random() * 30), "#000"
          m.x = Math.random() * @width
          m.y = 100 + (Math.random() * @height - 100)
          m.setup()
          _.magnets.push m
          i++

      update:->

        if $("body").css("cursor") is "move"
          $("body").css "cursor":"default"

        is_already_dragging = false

        if _.ball.dragging

          @follow_mouse()

        for m in _.magnets
          m.update()
          if _.started and !_.ball.dragging
            m.attract _.ball

        @check_bounds()

        if _.started
          _.ball.update()

      check_bounds:->

        if _.ball.x >= @width or _.ball.x <= 0

          _.ball.vx *= -1
          _.ball.vx *= 0.7

        if _.ball.y >= @height or _.ball.y <= 0

          _.ball.vy *= -1
          _.ball.vy *= 0.7


      follow_mouse:->

        deg = Calc.ang _.ball.x, _.ball.y, @mouse.x, @mouse.y
        rad = Calc.deg2rad deg

        fx = Math.cos(rad) * 2
        fy = Math.sin(rad) * 2

        _.ball.apply_force fx, fy

      draw:->

        _.ball.draw()

        for m in _.magnets
          m.draw_lines_to _.ball
          m.draw()

      mousedown:->

        _.ball.dragging = true

      mouseup:->

        _.ball.dragging = false


