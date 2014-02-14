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

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        s.target = new Target 100, "#fff"
        s.target.x = @width / 2
        s.target.y = @height / 2

        s.ball = new Ball 20, "#ff0000"
        s.ball.speed = 1
        s.ball.x = Math.random() * @width
        s.ball.y = Math.random() * @height


      update:()->

        force = s.target.attract(s.ball)

        force.x *= -1
        force.y *= -1

        s.ball.apply_force force
        s.ball.update()

      draw:()->

        s.target.draw()
        s.ball.draw()



