Draw = require("draw/draw")

module.exports = class Bound

  ctx: {}
  x: 0
  y: 0
  h: 0
  w: 0

  constructor:(@x, @y, @w, @h, @fill = "#fff")->

  update:->

  draw:(@ctx)->

    @ctx = Draw.CTX unless @ctx
    @ctx.fillStyle = @fill
    @ctx.beginPath()
    @ctx.fillRect @x, @y, @w, @h
    @ctx.closePath()
    @ctx.fill()


