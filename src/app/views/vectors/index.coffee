AppView = require 'app/views/app_view'
Draw = require("draw/draw")
Ball = require "./ball"

module.exports = class Index extends AppView

  NUM_BALLS= 1

  after_render:()->

    NUM_BALLS = ($(window).width() + $(window).height())

    ctx = window.Sketch.create

      container:@el.get(0)

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        @balls = []
        i = 0

        while i < NUM_BALLS
          ball = new Ball 2, "#ffffff"
          ball.x = Math.random() * @width
          ball.y = Math.random() * @height
          ball.setup()
          @balls.push ball
          i++

      update:()->
        ball.update(@mouse.x, @mouse.y) for ball in @balls

      draw:()->
        # Draw.CTX.strokeStyle = "#ffffff";
        # Draw.CTX.beginPath()
        # Draw.CTX.moveTo 0, 0
        # Draw.CTX.lineTo @mouse.x, @mouse.y
        # Draw.CTX.stroke();
        # Draw.CTX.closePath()
        ball.draw() for ball in @balls

