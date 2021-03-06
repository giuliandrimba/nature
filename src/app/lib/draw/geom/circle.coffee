Draw = require("../draw")

module.exports = class Circle

  radius:0
  fill:"#ff0000"
  opacity:1
  stroke:"#000000"
  x:0
  y:0

  constructor:(@radius, @fill, @stroke, @strokeWidth = 1)->


  draw:(@ctx)->
    @ctx = Draw.CTX unless @ctx
    @ctx.globalAlpha = @opacity
    @ctx.fillStyle = @fill
    @ctx.lineWidth = @strokeWidth if @stroke
    @ctx.strokeStyle = @stroke if @stroke
    @ctx.beginPath()
    @ctx.arc @x, @y, @radius, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()
    @ctx.stroke() if @stroke
    @ctx.globalAlpha = 1


