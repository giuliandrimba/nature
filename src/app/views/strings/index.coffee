AppView = require 'app/views/app_view'
Ball = require "./ball"
String = require "./string"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  NUM_COLS: 20
  NUM_ROWS: 20

  STRING_DIST: 15
  GRAVITY: 0.05
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

      autoclear:true

      setup:->

        _.CENTER_X = (@width / 2) - (_.NUM_COLS * _.STRING_DIST / 2)
        _.CENTER_Y = (@height / 2) - (_.NUM_ROWS * _.STRING_DIST / 2)

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @build_grid()


        _.points[0][0].pin()
        _.points[0][10].pin()
        _.points[0][_.NUM_COLS - 1].pin()


      update:->

        @iterate (ball, row, col)=>

          ball.apply_force 0, _.GRAVITY
          ball.apply_force -_.GRAVITY, 0

          ball.update()

        for s in _.strings

          s.update()

      draw:->

        Draw.CTX.globalAlpha = 0.1
        Draw.CTX.fillStyle = "#000"
        Draw.CTX.strokeStyle = '#FFFFFF'
        Draw.CTX.lineWidth = 1
        Draw.CTX.beginPath()

        for s in _.strings

          Draw.CTX.moveTo s.p1.x,  s.p1.y
          Draw.CTX.lineTo s.p2.x,  s.p2.y

        Draw.CTX.closePath()
        Draw.CTX.fill()
        Draw.CTX.stroke()
        Draw.CTX.globalAlpha = 1

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


            if cols > 0

              string = new String _.points[rows][cols - 1], _.points[rows][cols]
              _.strings.push string

            if rows > 0

              string = new String _.points[rows][cols], _.points[rows - 1][cols]
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




