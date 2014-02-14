AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Ball = require "./ball"
Target = require "./target"

module.exports = class Index extends AppView

  NUM_BALLS = 1

  ball: null
  target: null
  

  after_render:()=>

    s = @
    dir = {}

    ctx = window.Sketch.create

      container: @el.get(0)
      autoclear: false

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        s.target = new Target 50, "#fff"
        s.target.x = @width / 2
        s.target.y = @height / 2

        s.ball = new Target 10, "#fff"
        s.ball.speed = 1
        s.ball.x = Math.random() * @width
        s.ball.y = Math.random() * @height


      update:()->

        force = s.target.attract(s.ball)
        force2 = s.ball.attract(s.target)

        force.x *= -1
        force.y *= -1

        force2.x *= -1
        force2.y *= -1


        s.ball.apply_force force
        s.target.apply_force force2
        s.ball.update()
        s.target.update()

      draw:()->
        Draw.CTX.fillStyle = "rgba(0, 0, 0, 1)"
        Draw.CTX.fillRect 0, 0, @width, @height
        s.target.draw()
        s.ball.draw()



