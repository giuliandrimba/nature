Draw = require("draw/draw")
Vector = require "./vector"

module.exports = class Path

  ctx: {}
  x: 0
  y: 0
  h: 0
  w: 0

  points: []
  keypoints: []

  constructor:(@w, @h, @fill = "#fff")->

  update:->

  add_point:(x, y, ang)->

    p = Vector.new()
    p.x = x
    p.y = y
    p.ang= ang

    @points.push p

  draw:(@ctx)->

    @ctx = Draw.CTX unless @ctx
    @ctx.strokeStyle = "#ffffff"
    @ctx.lineWidth = @h
    @ctx.beginPath()

    i = 0


    while i < @points.length

      p = @points[i]

      if i is 0
        @fx = p.x
        @fy = p.y
        @ctx.moveTo p.x, p.y

      @ctx.lineTo p.x, p.y

      i++

    @ctx.stroke()
    @ctx.closePath()


