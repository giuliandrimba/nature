AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Ball = require "./ball"

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

        while i < NUM_BALLS

          radius = 5
          ball = new Ball radius, "#fff", "#000"
          ball.speed = 0.1
          ball.x = (@width / 2) + (-(Math.random() * @width) + (Math.random() * @width))
          ball.y = (@height / 2) + (-(Math.random() * @height) + (Math.random() * @height))
          ball.z = Math.random() * radius
          s.balls.push ball
          i++


      update:()->

        mouse = @mouse

        mouse.x = @width / 2 if mouse.x is 0
        mouse.y = @height / 2 if mouse.y is 0

        for b, i in s.balls

          ang = Calc.ang b.x, b.y, mouse.x, mouse.y
          rad = Calc.deg2rad ang
          dist = Calc.dist b.x, b.y, mouse.x, mouse.y

          fx = (Math.cos rad) * 10
          fy = (Math.sin rad) * 10

          if s.down
            fx *= -1
            fy *= -1

          else if dist < 50
            fx *= -1
            fx *= 10
            fy *= -1
            fy *= 5

          if Math.abs(b.vx) > 50
            b.vx *= 0.9
          if Math.abs(b.vy) > 50
            b.vy *= 0.9

          b.apply_force fx, fy

          b.update()


      draw:()->
        Draw.CTX.globalCompositeOperation = "multiply"
        Draw.CTX.fillStyle = "rgba(0,0,0,0.07)"
        Draw.CTX.fillRect(0, 0, @width, @height)
        Draw.CTX.globalCompositeOperation = 'source-over';

        for b, i in s.balls

          b.draw()

      mousedown:->
        s.down = true

      mouseup:->
        s.down = false

