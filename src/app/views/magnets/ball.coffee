Circle = require "draw/geom/circle"
Draw = require "draw/draw"

module.exports = class Ball extends Circle

  x: 0
  y: 0
  mass: 0
  vx: 0
  vy: 0
  ax: 0
  ay: 0
  speed: 1
  spring: 0.9
  collided: false
  dragging: false

  constructor:->
    super
    @mass = @radius

  apply_force:(fx, fy)->

    @ax += fx
    @ay += fy

  update:->

    @vx += @ax
    @vy += @ay

    if !@dragging

      if @vx > 5
        @vx = 5

      if @vy > 5
        @vy = 5

    else

      @vx *= @spring
      @vy *= @spring


    @ax = 0
    @ay = 0

  draw:->

    @x += @vx * @speed
    @y += @vy * @speed

    super

