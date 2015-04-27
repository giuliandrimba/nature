AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Ball = require "./ball"

module.exports = class Index extends AppView

  NUM_BALLS = 500

  ball: null
  target: null

  balls: []
  center: null

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>
    setTimeout @init, 1500

  init:()=>

    s = @
    dir = {}
    @balls = []

    if @ctx
      @ctx.clear()
      @ctx.destroy()

    @ctx = window.Sketch.create

      container: @el.get(0)
      autoclear: false

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        Draw.CTX.fillStyle = "rgba(0,0,0,1)";
        Draw.CTX.fillRect(0, 0, @width, @height);

        i = 0

        while i < NUM_BALLS

          radius = 1
          ball = new Ball radius, "#fff"
          ball.speed = Math.random() / 2
          ball.opacity = Math.random() / 2
          ball.x = (@width / 2) + (-(Math.random() * @width) + (Math.random() * @width))
          ball.init_x = ball.x
          ball.y = (@height / 2) + (-(Math.random() * @height) + (Math.random() * @height))
          ball.init_y = ball.y
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
          total_dist = Calc.dist b.init_x, b.init_y, mouse.x, mouse.y

          # b.opacity = Math.abs(((dist * 100 / total_dist) / 100))
          # b.speed = (b.opacity) / 10

          rndx = (Math.random() * 50)
          rndy = (Math.random() * 30)

          fx = (Math.cos rad) * 10
          fy = (Math.sin rad) * 10

          min_dist = 30

          if s.down
            min_dist = 100

          if dist < min_dist + rndx

            b.vx = 0
            b.vy = 0
            b.x = b.init_x = Math.random() * @width
            b.y = b.init_y = Math.random() * @height

          if Math.abs(b.vx) > 30
            b.vx *= 0.9
          if Math.abs(b.vy) > 30
            b.vy *= 0.9

          b.apply_force fx, fy

          b.update()


      draw:()->
        Draw.CTX.fillStyle = "rgba(0,0,0,0.08)"
        Draw.CTX.fillRect(0, 0, @width, @height)

        for b, i in s.balls

          b.draw()

      mousedown:->
        s.down = true

      mouseup:->
        s.down = false

