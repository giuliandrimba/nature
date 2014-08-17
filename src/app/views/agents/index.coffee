AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Bound = require "./bound"
Agent = require "./agent"
Vector = require "./vector"
Circle = require "draw/geom/circle"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    @ctx = window.Sketch.create

      container:@el.get(0)

      autoclear:true

      bound: {}
      path: {}
      agent: {}

      start: {}
      end: {}

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

        @_w = 800
        @_h = 350
        @_x = @width / 2 - (@_w / 2)
        @_y = @height / 2 - (@_h / 2) - 30

        @path = new Bound @_x - 1, (@_y + (@_h / 2 - 15)), @_w + 2, 30, "#000"

        @agent = new Agent 5, "#fff"

        @agent.x = @path.x
        @agent.y = @path.y - 100


      mousemove:->

      update:->

        @agent.update()
        @agent.follow @path


      draw:->

        @path.draw()
        @agent.draw()

