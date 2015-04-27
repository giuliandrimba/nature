AppView = require 'app/views/app_view'
Draw = require("draw/draw")
Ball = require "./ball"
Target = require "./target"

module.exports = class Index extends AppView

  NUM_BALLS= 1

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:()->

    NUM_BALLS = ($(window).width() + $(window).height()) / 2

    if @ctx
      @ctx.clear()
      @ctx.destroy()

    @ctx = window.Sketch.create

      container:@el.find(".lab").get(0)

      setup:()->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        @balls = []
        i = 0

        while i < NUM_BALLS
          ball = new Ball 1, "#ffffff"
          ball.x = Math.random() * @width
          ball.y = Math.random() * @height
          ball.setup(Draw.CTX)
          @balls.push ball
          i++

      mousedown:()->


      update:()->
        ball.update(@mouse.x, @mouse.y) for ball in @balls

      draw:()->
        ball.draw() for ball in @balls

