AppView = require 'app/views/app_view'
Ball = require "./ball"
Constraint = require "./constraint"
Draw = require "draw/draw"
Calc = require "draw/math/calc"
Audio = require "./audio"

module.exports = class Index extends AppView

  title: "Natura : Strings & Dots"

  NUM_COLS: 24
  NUM_ROWS: 24

  STRING_DIST: 15
  GRAVITY: 0.05
  CENTER_X: 0
  CENTER_Y: 0

  points: []
  strings: []

  audio: {}

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    _ = @

    @points = []
    @strings = []

    @ctx = window.Sketch.create

      container:@el.find(".lab").get(0)

      autoclear:true
      fullscreen: true
      retina: false

      resize:->

        _.STRING_DIST = (15 * 200) / @width

        _.CENTER_X = (@width / 2) - (_.NUM_COLS * _.STRING_DIST / 2)
        _.CENTER_Y = (@height / 2) - (_.NUM_ROWS * _.STRING_DIST / 2)

        @build_grid()
        @draw()

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @resize()


        @iterate (ball, row, col)=>

          if row is 29
            _.points[row][col].pin()

      update:->

        for s in _.strings

          s.update(@drag)


        if (@drag)

          md = Calc.dist @drag.x, @drag.y, @mouse.x, @mouse.y

          @drag.x = @mouse.x
          @drag.y = @mouse.y

        @iterate (ball, row, col)=>

          ball.update()

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

      mousedown:->

        range = 1000
        dragging_ball = null

        @iterate (ball, row, col)=>
          dd = Calc.dist ball.x, ball.y, @mouse.x, @mouse.y

          if dd < range

            range = dd

            unless ball._pin
              dragging_ball = ball


        @drag = dragging_ball

      mouseup:->

        @drag = null

      build_grid:->

        angle = 0
        step = 360 / 20
        dist = @width / 75
        dist_step = @width / 150

        _.points = []
        _.strings = []

        rows = 0
        while rows < _.NUM_ROWS

          cols = 0

          _.points[rows] = []

          dist += dist_step

          while cols < _.NUM_COLS

            ball = new Ball 1, "#fff"

            angle += step
            rad = Calc.deg2rad angle


            x = (@width / 2) + (Math.cos(rad) * dist)
            y = (@height / 2) + (Math.sin(rad) * dist)

            ball.pos x, y

            _.points[rows][cols] = ball


            if cols > 0

              string = new Constraint _.points[rows][cols - 1], _.points[rows][cols]
              _.strings.push string

            if rows > 0

              string = new Constraint _.points[rows][cols], _.points[rows - 1][cols]
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




