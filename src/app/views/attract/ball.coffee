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
  MAX_SPEED : 50

  constructor:->
    super
    @mass = @radius

  apply_force:(fx, fy)->

    fx /= @mass
    fy /= @mass

    @ax += fx
    @ay += fy

  update:()->

    @vx += @ax
    @vy += @ay

    @x += @vx * @speed
    @y += @vy * @speed

    @ax = 0
    @ay = 0

  draw:->
    super

