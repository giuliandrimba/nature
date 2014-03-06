AppView = require 'app/views/app_view'
Ball = require "./ball"
Magnet = require "./magnet"
Target = require "./target"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  magnets: []
  dragging: false
  started: false

  after_render:=>

    _ = @

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        _.ball = new Ball 20, "#000", "#fff", 4
        _.ball.x = 50
        _.ball.y = @height / 2

        _.target = new Target

        _.target.y = @height - 150
        _.target.x = @width - 150

        i = 0

        while i < parseInt($(window).width() / 250)

          m = new Magnet 25 + (Math.random() * 50), "#FFF"
          m.x = Math.random() * @width
          m.y = Math.random() * @height - 100
          _.magnets.push m
          i++


      is_mouse_over:(magnet)->

        if @mouse.x > (magnet.x - magnet.radius) and @mouse.x < (magnet.x + magnet.radius) and @mouse.y > (magnet.y - magnet.radius) and @mouse.y < (magnet.y + magnet.radius)
          return true

        return false

      update:->

        is_already_dragging = false

        for m in _.magnets
          if m.dragged
            is_already_dragging = true
            break

        for m in _.magnets
          m.update() 
          if _.started
            m.attract _.ball
          if @is_mouse_over(m) and _.dragging and !is_already_dragging
            m.dragged = true

          if m.dragged
            is_already_dragging = true
            m.x = @mouse.x
            m.y = @mouse.y

        @check_collision()

        _.target.attract _.ball

        if _.started
          _.ball.update()

        _.target.update()

        @reached_target()

      check_collision:->

        for m in _.magnets

          dist = Calc.dist m.x, m.y, _.ball.x, _.ball.y

      reached_target:->

        dist = Calc.dist _.target.x, _.target.y, _.ball.x, _.ball.y

        if dist < _.target.radius
          _.target.mass = 500
          _.ball.vx *= 0.5
          _.ball.vy *= 0.3

        if dist < 2
          _.ball.vx = 0
          _.ball.vy = 0

      draw:->

        m.draw() for m in _.magnets

        _.target.draw()
        _.ball.draw()

      mousedown:->

        _.dragging = true

      keydown:->
        if !_.started
          _.started = true
        else
          _.started = false
          _.ball.x = 50
          _.ball.y = @height / 2
          _.ball.vx = 0
          _.ball.vy = 0

      mouseup:->

        _.dragging = false

        for m in _.magnets
          m.dragged = false

