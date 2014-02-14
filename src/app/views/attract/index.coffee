AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Ball = require "./ball"
Target = require "./target"

module.exports = class Index extends AppView

  NUM_BALLS = 200

  ball: null
  target: null

  balls: []
  center: null

  after_render:()=>

    s = @
    dir = {}

    ctx = window.Sketch.create

      container: @el.get(0)
      autoclear: false

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        i = 0

        s.center = new Target 100, "#000"
        s.center.mass = 500
        s.center.x = @width / 2
        s.center.y = @height / 2

        s.balls.push s.center

        while i < NUM_BALLS

          radius = Math.random() * 15
          ball = new Target radius, "#fff"
          ball.speed = 0.01
          ball.x = Math.random() * @width
          ball.y = Math.random() * @height
          s.balls.push ball
          i++


      update:()->

        s.attract_all(s.balls)

      draw:()->
        Draw.CTX.fillStyle = "rgba(0, 0, 0, 0.1)"
        Draw.CTX.fillRect 0, 0, @width, @height
        for ball, i in s.balls
          ball.draw()

  attract_all:(balls)=>

    for b, i in balls

      dist = Calc.dist(b.x, b.y, @.center.x, @.center.y)

      opacity = dist / 100

      if opacity > 1
        opacity = 1

      if i > 0
        b.opacity = opacity

      if i > 0

        for b2 in balls

          unless b is b2

            f = b2.attract b
            b.apply_force f

        b.update()



