AppView = require 'app/views/app_view'
Draw = require("draw/draw")
Ball = require "./ball"
Target = require "./target"

module.exports = class Index extends AppView

  NUM_BALLS= 1

  after_render:()->

    NUM_BALLS = ($(window).width() + $(window).height()) / 2

    ctx = window.Sketch.create

      container:@el.get(0)

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        # @target = new Target 20, "#ffffff"
        # @target.set_target @mouse.x, @mouse.y

        @balls = []
        i = 0

        while i < NUM_BALLS
          ball = new Ball 1, "#ffffff"
          # ball.x = @width - 10
          ball.x = Math.random() * @width
          # ball.y = @height - 10
          ball.y = Math.random() * @height
          ball.setup(Draw.CTX)
          @balls.push ball
          i++

      mousedown:()->
        # @target.set_target @mouse.x, @mouse.y

      update:()->
        # if @dragging
          # @target.set_target @mouse.x, @mouse.y
        # @target.update()
        ball.update(@mouse.x, @mouse.y) for ball in @balls

      draw:()->
        # Draw.CTX.strokeStyle = "#ffffff";
        # Draw.CTX.beginPath()
        # Draw.CTX.moveTo 0, 0
        # Draw.CTX.lineTo @mouse.x, @mouse.y
        # Draw.CTX.stroke();
        # Draw.CTX.closePath()
        ball.draw() for ball in @balls
        # @target.draw()

