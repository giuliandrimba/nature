AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

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

      update:->

      draw:->

      mousedown:->

