AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Cell = require "./cell"

module.exports = class Index extends AppView

  destroy:=>
    @ctx?.clear()
    @ctx?.destroy()
    super

  after_render:=>
    setTimeout @init, 1500

  init:=>

    @ctx?.clear()
    @ctx?.destroy()


    w = $(window).width()
    h = $(window).height()
    @canvas = @el.find("#lab-automata").find("canvas")
    @canvas.remove()

    @ctx = window.Sketch.create

      container:@el.find("#lab-automata").get(0)
      fullscreen: false
      width: w
      height: h
      cells: []
      next_cells: []
      w: 20
      clicked: false
      frame_rate: 2
      frame: 0
      autoclear: false

      setup:->
        setTimeout (()=> $(@container).find("canvas").addClass("tween")), 0
        Draw.CTX = $(".sketch").get(0).getContext("2d")

        Draw.CTX.fillStyle = "rgba(0,0,0,0.08)"
        Draw.CTX.fillRect(0, 0, @width, @height);

        @columns = (@width) / @w
        @rows = (@height) / @w

        @init()

      init:->

        @cells = []

        x = 0

        while x < @columns - 1

          y = 0

          @cells[x] = []

          while y < @rows - 1

            state = Math.round(Math.random(2))

            @cells[x][y] = new Cell state, 20 + x * @w, 20 + y * @w

            y++

          x++

      generate:->

        for c, x in @cells

          for r, y in c

            @set_state x, y, @cells.length - 1, c.length - 1


      set_state:(x, y, total_columns, total_rows)->

        neighbors = 0
        cell = @cells[x][y]
        cell.previous = cell.state

        i = - 1

        while i <= 1

          j = - 1

          while j <= 1

            if x > 0 and y > 0 and x < total_columns and y < total_rows

              neighbors += @cells[x + i][y + j].previous

            j++

          i++

        if cell.state is 1 and neighbors > 0

          neighbors -= cell.state

        if cell.previous is 1 and neighbors < 2
          cell.state = 0
        else if cell.previous is 1 and neighbors > 3
          cell.state = 0
        else if cell.previous is 0 and neighbors is 3

          cell.state = 1


      update:->

        @frame++

        if @frame > @frame_rate

          @frame = 0

          @generate()

      mousedown:->

        @init()

      draw:->

        Draw.CTX.fillStyle = "rgba(0,0,0,0.08)"
        Draw.CTX.fillRect(0, 0, @width, @height)

        for row in @cells

          for c in row

            c.draw Draw.CTX, @

