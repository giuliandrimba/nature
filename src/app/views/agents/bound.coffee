Draw = require("draw/draw")
Vector = require "./vector"

module.exports = class Bound

  ctx: {}
  x: 0
  y: 0
  h: 0
  w: 0

  points: []

  constructor:(@w, @h, @fill = "#fff")->

  update:->

  add_point:(x, y)->

    p = Vector.new()
    p.x = x
    p.y = y

    @points.push p

  draw:(@ctx)->

    @ctx = Draw.CTX unless @ctx
    @ctx.strokeStyle = "#ff0000"
    @ctx.lineWidth = @h
    @ctx.beginPath()
    for p, i in @points

      if i is 0
        @ctx.moveTo p.x, p.y

      @ctx.lineTo p.x, p.y

    @ctx.stroke()
    @ctx.closePath()


