AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Cell = require "./cell"

module.exports = class Index extends AppView

  destroy:=>
    @ctx.clear()
    @ctx.destroy()
    super

  after_render:=>

    @ctx = window.Sketch.create

      container:@el.get(0)
      cells: []

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")

        @generate()

      generate:->

        i = 0

        while i < 100

          @cells.push new Cell i*15, 100

          i++

      mousedown:->


      mouseup:->


      mousemove:->


      update:->

      draw:->

        for c in @cells

          c.draw Draw.CTX

