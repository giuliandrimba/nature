AppView = require 'app/views/app_view'
Ball = require "./ball"
String = require "./string"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  NUM_COLS: 30
  NUM_ROWS: 30

  STRING_DIST: 15
  GRAVITY: 0.1
  CENTER_X: 0
  CENTER_Y: 0

  points: []
  strings: []
  balls: []

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    _ = @

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

        _.CENTER_X = (@width / 2) - (_.NUM_COLS * _.STRING_DIST / 2)
        _.CENTER_Y = (@height / 2) - (_.NUM_ROWS * _.STRING_DIST / 2)

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @build_grid()


        _.points[0][0].x -= 100
        _.points[0][0].pin()
        _.points[0][_.NUM_COLS - 1].x += 100
        _.points[0][_.NUM_COLS - 1].pin()

        _.points[0][15].pin()


      update:->

        for s in _.strings

          s.update()

        @iterate (ball, row, col)=>

          if row > 1

            ball.apply_force 0, _.GRAVITY

          ball.update()


      draw:->

        @iterate (ball, row, col)=>

          ball.draw()


      build_grid:->

        rows = 0
        while rows < _.NUM_ROWS

          cols = 0

          _.points[rows] = []

          while cols < _.NUM_COLS

            ball = new Ball 1, "#fff"

            ball.pos _.CENTER_X + _.STRING_DIST * cols, _.CENTER_Y + _.STRING_DIST * rows

            _.points[rows][cols] = ball

            if rows > 0

              string = new String _.points[rows][cols], _.points[rows - 1][cols], _.STRING_DIST
              _.strings.push string

            if cols > 0

              string = new String _.points[rows][cols - 1], _.points[rows][cols], _.STRING_DIST
              _.strings.push string


            cols++
          

          rows++

      iterate:(fn)->

        rows = 0

        while rows < _.points.length

          cols = 0

          while cols < _.NUM_COLS

            fn(_.points[rows][cols], rows, cols)

            cols++

          rows++




