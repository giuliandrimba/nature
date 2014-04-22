AppView = require 'app/views/app_view'
Ball = require "./ball"
String = require "./string"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  NUM_COLS: 10
  NUM_ROWS: 10

  STRING_DIST: 30
  GRAVITY: 10
  CENTER_X: 0
  CENTER_Y: 0

  points: []
  strings: []

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



      update:->

        for s in _.strings

          s.update()

        @iterate (ball, row, col)=>

          if row > 0
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

            ball.x = _.CENTER_X + _.STRING_DIST * cols
            ball.y = _.CENTER_Y + _.STRING_DIST * rows

            _.points[rows][cols] = ball

            if rows > 0

              string = new String _.points[rows - 1][cols], _.points[rows][cols], _.STRING_DIST
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




