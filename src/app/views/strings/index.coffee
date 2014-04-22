AppView = require 'app/views/app_view'
Ball = require "./ball"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  NUM_COLS: 10
  NUM_ROWS: 10

  STRING_DIST: 30

  CENTER_X: 0
  CENTER_Y: 0

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

      draw:->

        @iterate (ball, row, col)=>

          ball.draw()


      build_grid:->

        rows = 0
        while rows < _.NUM_ROWS

          cols = 0

          _.strings[rows] = []

          while cols < _.NUM_COLS

            ball = new Ball 1, "#fff"
            ball.y = _.CENTER_Y + _.STRING_DIST * rows
            ball.x = _.CENTER_X + _.STRING_DIST * cols

            _.strings[rows][cols] = ball

            cols++

          rows++

      iterate:(fn)->

        rows = 0

        while rows < _.strings.length

          cols = 0

          while cols < _.NUM_COLS

            fn(_.strings[rows][cols], rows, cols)

            cols++

          rows++




