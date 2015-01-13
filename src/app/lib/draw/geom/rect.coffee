Draw = require("../draw")

module.exports = class Rect

  radius:0
  fill:"#ff0000"
  opacity:1
  stroke:"#000000"
  x:0
  y:0

  constructor:(@radius, @fill, @stroke, @strokeWidth = 1)->

    @width = @height = @radius

  draw:(@ctx)->
    @ctx = Draw.CTX unless @ctx
    @ctx.globalAlpha = @opacity
    @ctx.fillStyle = @fill
    # @ctx.lineWidth = @strokeWidth if @stroke
    # @ctx.strokeStyle = @stroke if @stroke
    @ctx.beginPath()
    @ctx.rect @x - @width / 2, @y - @height / 2 , @width, @height
    @ctx.closePath()
    @ctx.fill()
    # @ctx.stroke() if @stroke
    @ctx.globalAlpha = 1


