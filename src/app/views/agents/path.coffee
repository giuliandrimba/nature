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
  opacity:0

  constructor:(@w, @h)->

    @points = []
    @keypoints = []

  show:=>

  hide:=>

  update:(@mouse)->

    if $("body").css("cursor") is "move"
      $("body").css "cursor":"default"

    is_already_dragging = false

    for k in @keypoints
      if k.dragged
        is_already_dragging = true
        break

    @show_path = false

    for k in @keypoints

      if @is_mouse_near(k)
        @show_path = true

      if @is_mouse_over(k) and @dragging and !is_already_dragging

        k.dragged = true

      if k.dragged
        is_already_dragging = true
        k.x = @mouse.x
        k.y = @mouse.y
        @points[k.index].x = k.x + 5
        @points[k.index].y = k.y + 5

      if @is_mouse_over(k)
        $("body").css "cursor":"move"

      k.update(@mouse)

    @show_hide_path()

  show_hide_path:=>

    if @show_path

      @opacity += 0.05 if @opacity < 1

    else

      @opacity -= 0.05 if @opacity > 0


  add_point:(x, y, ang)->

    p = Vector.new()
    p.x = x
    p.y = y
    p.ang = ang

    @points.push p
    c = new KeyPoint 5, "#fff"
    c.x = x
    c.y = y
    c.index = @points.length - 1
    @keypoints.push c

  is_mouse_near:(circle)->

    dist = Calc.dist @mouse.x, @mouse.y, circle.x, circle.y

    if dist < 250
      return true

    return false

  is_mouse_over:(circle)->

    if @mouse.x > (circle.x - circle.radius) and @mouse.x < (circle.x + circle.radius) and @mouse.y > (circle.y - circle.radius) and @mouse.y < (circle.y + circle.radius)
      return true

    return false

  draw:(@ctx)->

    @ctx = Draw.CTX unless @ctx
    @ctx.strokeStyle = "rgba(255,255,255,#{@opacity})"
    @ctx.lineWidth = 1
    @ctx.strokeWidth = 3
    @ctx.beginPath()
    @ctx.setLineDash([1,20])

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

    for c in @keypoints
      c.draw()

  mousedown:->

    @dragging = true

  mouseup:->

    @dragging = false

    for k in @keypoints
      k.dragged = false


