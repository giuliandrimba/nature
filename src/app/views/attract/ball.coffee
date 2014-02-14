Circle = require "draw/geom/circle"
Draw = require "draw/draw"

module.exports = class Ball extends Circle

  x: 0
  y: 0
  force: 0
  mass: 0
  vx: 0
  vy: 0
  ax: 0
  ay: 0
  speed: 1

  constructor:->
    super
    @mass = @radius

  apply_force:(@force)->

    @force.x /= @mass
    @force.y /= @mass

    @ax += @force.x
    @ay += @force.y

  update:()->

    @vx += @ax
    @vy += @ay

    @x += @vx * @speed
    @y += @vy * @speed

    @ax = 0
    @ay = 0

  draw:->
    super

