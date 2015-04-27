Draw = require("draw/draw")
Vector = require "./vector"
Circle = require "draw/geom/circle"
KeyPoint = require "./keypoint"
Calc = require "draw/math/calc"

module.exports = class Path

  ctx: {}
  x: 0
  y: 0
  h: 0
  w: 0

  points: []
  keypoints: []
  dragging: false
  opacity:1

  constructor:(@w, @h)->

    @points = []
    @keypoints = []

  show:=>

  hide:=>

  update:(@mouse, @mouse_moving, @radius)->

    if $("body").css("cursor") is "move"
      $("body").css "cursor":"default"

    is_already_dragging = false

    for k in @keypoints

      k.update(@mouse, @radius)

  update_point:(x, y, ang)->

    p = Vector.new()
    p.x = x
    p.y = y
    p.ang = ang

    @points.push p
    c = new KeyPoint 5, "#fff"
    c.x = x
    c.y = y
    c.ang = ang
    c.index = @points.length - 1
    @keypoints.push c


  add_point:(x, y, ang)->

    p = Vector.new()
    p.x = x
    p.y = y
    p.ang = ang

    @points.push p
    c = new KeyPoint 10, "#fff"
    c.x = x
    c.y = y
    c.ang = ang
    c.index = @points.length - 1
    @keypoints.push c

  draw:(@ctx)->

    @ctx = Draw.CTX unless @ctx
    @ctx.strokeStyle = "rgba(255,255,255,#{@opacity})"
    @ctx.lineWidth = 1
    @ctx.strokeWidth = 1
    @ctx.beginPath()
    @ctx.setLineDash([1,20])

    for c, i in @keypoints

      if i is 0
        @ctx.moveTo c.x, c.y

      @ctx.lineTo c.x, c.y

    @ctx.stroke()
    @ctx.closePath()

    for c, i in @keypoints

      c.draw()


  mousedown:->

    @dragging = true

  mouseup:->

    @dragging = false

    for k in @keypoints
      k.dragged = false


