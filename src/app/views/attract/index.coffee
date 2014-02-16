AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Ball = require "./ball"
Target = require "./target"

module.exports = class Index extends AppView

  NUM_BALLS = 100

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
        s.center.mass = 1000
        s.center.x = @width / 2
        s.center.y = @height / 2
        s.center.z = Math.random() * 100

        s.balls.push s.center

        while i < NUM_BALLS

          radius = Math.random() * 15
          ball = new Target radius, "#fff"
          ball.speed = 0.1
          ball.x = (@width / 2) + (-(Math.random() * @width) + (Math.random() * @width))
          ball.y = (@height / 2) + (-(Math.random() * @height) + (Math.random() * @height))
          ball.z = Math.random() * radius
          s.balls.push ball
          i++


      update:()->

        s.attract_all(s.balls)

      draw:()->
        Draw.CTX.fillStyle = "rgba(0, 0, 0, 0.1)"
        Draw.CTX.fillRect 0, 0, @width, @height
        for ball, i in s.balls
          if i is 0
            # Draw.CTX.globalCompositeOperation = "lighter"
            ball.draw()
            # Draw.CTX.globalCompositeOperation = "source-over"
          else
            ball.draw()

      mousemove:->
        s.center.x = @mouse.x
        s.center.y = @mouse.y

  attract_all:(balls)=>

    for b, i in balls

      if i > 0

        ang = Calc.ang b.x, b.y, @center.x, @center.y
        rad = Calc.deg2rad ang
        dist = Calc.dist b.x, b.y, @center.x, @center.y

        f = {}
        f.x = (Math.cos rad) * 10
        f.y = (Math.sin rad) * 10
        f.z = (Math.sin rad) * 10

        # b.radius = dist / 100


        if Math.abs(b.vx) > 50
          b.vx *= 0.9
        if Math.abs(b.vy) > 50
          b.vy *= 0.9

        b.apply_force f

        b.update()



