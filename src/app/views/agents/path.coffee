Draw = require("draw/draw")
Vector = require "./vector"
Circle = require "draw/geom/circle"
Rect = require "draw/geom/rect"

module.exports = class Path

  ctx: {}
  x: 0
  y: 0
  h: 0
  w: 0

  points: []
  keypoints: []
  dragging: false

  constructor:(@w, @h)->

    points = []

  update:(@mouse)->

    if $("body").css("cursor") is "move"
      $("body").css "cursor":"default"

    is_already_dragging = false

    for k in @keypoints
      if k.dragged
        is_already_dragging = true
        break

    for k in @keypoints

      if @is_mouse_over(k) and @dragging and !is_already_dragging
        k.dragged = true

      if k.dragged
        is_already_dragging = true
        k.x = @mouse.x - (k.radius / 2)
        k.y = @mouse.y - (k.radius / 2)
        @points[k.index].x = k.x + 5
        @points[k.index].y = k.y + 5

      if @is_mouse_over(k)
        $("body").css "cursor":"move"


  add_point:(x, y, ang)->

    p = Vector.new()
    p.x = x
    p.y = y
    p.ang= ang

    @points.push p
    c = new Rect 14, "#fff"
    # c.radius = 15
    # c = new Circle 20, "#000", "rgba(255,255,255,1)", 2
    c.x = x - (c.radius / 2)
    c.y = y - (c.radius / 2)
    c.index = @points.length - 1
    @keypoints.push c

  is_mouse_over:(circle)->

    if @mouse.x > (circle.x - circle.radius) and @mouse.x < (circle.x + circle.radius) and @mouse.y > (circle.y - circle.radius) and @mouse.y < (circle.y + circle.radius)
        return true

    return false

  draw:(@ctx)->

    @ctx = Draw.CTX unless @ctx
    @ctx.strokeStyle = "rgba(255,255,255,1)"
    @ctx.lineWidth = 1
    @ctx.beginPath()
    @ctx.setLineDash([2, 3])

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

    @ctx.setLineDash([0])

    for c in @keypoints

      c.draw()
      @ctx.fillStyle = "#000"
      @ctx.beginPath()
      @ctx.arc c.x + (c.radius / 2), c.y + (c.radius / 2), 1, 0, Math.PI*2,true
      @ctx.closePath()
      @ctx.fill()


  mousedown:->

    @dragging = true

  mouseup:->

    @dragging = false

    for k in @keypoints
      k.dragged = false


