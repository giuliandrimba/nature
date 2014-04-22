Circle = require "draw/geom/circle"

module.exports = class Ball extends Circle

  x: 0
  y: 0
  mass: 0
  vx: 0
  vy: 0
  ax: 0
  ay: 0
  speed: 0.1
  spring: 0.9

  constructor:->
    super 
    @mass = @radius

  apply_force:(fx, fy)->

    @ax += fx
    @ay += fy

  update:->

    @vx += @ax
    @vy += @ay

    if @vx > 50
      @vx = 50

    if @vy > 50
      @vy = 50


    @vx *= @spring
    @vy *= @spring

    @ax = 0
    @ay = 0

  draw:->

    @x += @vx * @speed
    @y += @vy * @speed

    super