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

        @bound = new Bound @_x, @_y, @_w, @_h
        @path = new Bound @_x - 1, (@_y + (@_h / 2 - 15)), @_w + 2, 30, "#000"

        @agent = new Agent 5, "#fff"

        @start = new Circle 5, "#00ff00"
        @end = new Circle 5, "#00ff00"

        @agent.x = @bound.x + 100
        @agent.y = @bound.y + 100


      mousemove:->

      update:->

        @path_distance()

        @agent.update()


      draw:->

        # @bound.draw()
        @path.draw()
        @agent.draw()
        @target.draw()
        @start.draw()
        @end.draw()

      path_distance:->

        predict = Vector.normalize @agent.vel
        predict = Vector.mult predict, 25
        predictLoc = Vector.add @agent.location(), predict

        path_start = Vector.new()
        path_start.x = @path.x
        path_start.y = @path.y + (25 / 2)

        path_end = Vector.new()
        path_end.x = @path.x + @path.w
        path_end.y = @path.y + (25 / 2)

        @start.x = path_start.x
        @start.y = path_start.y

        @end.x = path_end.x
        @end.y = path_end.y

        a = Vector.sub predictLoc, path_start
        b = Vector.sub path_end, path_start

        b = Vector.normalize b
        b = Vector.mult b, Vector.dot(a, b)

        @normal_point = Vector.add path_start, b

        @target = new Circle 2, "#ff0000"
        distance = Vector.dist predictLoc, @normal_point

        b = Vector.normalize b
        b = Vector.mult b, 25
        @target_loc = Vector.add @normal_point, b

        if distance > @path.h / 2

          @agent.seek @target_loc

        @target.x = @target_loc.x
        @target.y = @target_loc.y





