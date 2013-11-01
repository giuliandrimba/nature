AppView = require 'app/views/app_view'
Ball = require "./ball"
Draw = require("draw/draw")

module.exports = class Index extends AppView

  NUM_BALLS= 200

  after_render:()->

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:()->
        Draw.CTX = $(".sketch").get(0).getContext("2d");

        @balls = []
        i = 0

        while i < NUM_BALLS
          @balls.push new Ball
          i++

      update:()->
        ball.update(@mouse.x, @mouse.y) for ball in @balls

      draw:()->
        ball.draw() for ball in @balls

