Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"
Draw = require "draw/draw"

module.exports = class Magnet extends Circle

  dragged: false
  NUM_LINES: 0
  shadow: null
  vx: 0
  vy: 0
  spring: 0.3
  speed: 0.01

  MIN_DIST: 500

  constructor:->
    super
    @mass = @radius * 2
    @NUM_LINES = @radius / 5
    @shadow = new Circle @radius + 5, "#1A1F2B"

  update:->

    unless @dragged

      @dx = @iddle_x - @x
      @dy = @iddle_y - @y
      @ax = @dx * @spring
      @ay = @dy * @spring
      @vx += @ax
      @vy += @ay

      @x += @vx * @speed
      @y += @vy * @speed

      @ax = 0
      @ay = 0

  setup:->
    @initial_x = @x
    @initial_y = @y
    @iddle_x = @initial_x + (Math.random() * 10) + (-(Math.random() * 10))
    @iddle_y = @initial_y + (Math.random() * 10) + (-(Math.random() * 10))

  draw:(@ctx)->
    @shadow.x = @x + 2
    @shadow.y = @y + 2
    @shadow.draw(@ctx)
    super

  attract:(ball)->

    deg = Calc.ang @x, @y, ball.x, ball.y
    rad = Calc.deg2rad deg
    distance = Calc.dist @x, @y, ball.x, ball.y

    if distance < 250
      distance = 250

    strength = (@mass * ball.mass) / (distance * distance)
    fx = Math.cos(rad) * strength * 2
    fy = Math.sin(rad) * strength * 2

    # if distance < @MIN_DIST
    ball.apply_force -fx, -fy

  draw_lines_to:(ball)->
    @ctx = Draw.CTX unless @ctx
    i = 0
    opacity = 1

    dist = Calc.dist @x, @y, ball.x, ball.y

    if dist > @MIN_DIST
      return
    else
      opacity = 0.8 - (dist/@MIN_DIST)

    target_angle = Calc.ang @x, @y, ball.x, ball.y

    line_angle = target_angle + 90
    line_rad = Calc.deg2rad line_angle

    _radius = @radius * 0.8

    @ctx.globalCompositeOperation = "destination-over"
    @ctx.strokeStyle = "rgba(255,255,255,#{opacity})"
    @ctx.lineWidth = 1

    while i < (@NUM_LINES * 1.9)

      init_x = @x + (Math.cos line_rad) * _radius
      init_y = @y + (Math.sin line_rad) * _radius

      target_angle = Calc.ang init_x, init_y, ball.x, ball.y
      target_rad = Calc.deg2rad target_angle
      line_dist = Calc.dist init_x, init_y, ball.x, ball.y

      _x = init_x + (Math.cos target_rad) * line_dist
      _y = init_y + (Math.sin target_rad) * line_dist

      @ctx.moveTo init_x, init_y
      @ctx.lineTo _x, _y

      _radius -= @radius / @NUM_LINES


      i++

    @ctx.stroke()
    @ctx.globalCompositeOperation = "source-over"


  draw_dot:->

    @ctx.fillStyle = "#1A1F2B"
    @ctx.beginPath()
    @ctx.arc @x, @y, 10, 0, Math.PI*2, true
    @ctx.closePath()
    @ctx.fill()




