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
  spring: 0.8
  _pin: false
  time_elapsed:1.3

  constructor:->
    super 
    @mass = @radius

  pos:(x, y)->
    @x = x
    @y = y

  apply_force:(fx, fy)->

    @ax += fx
    @ay += fy

  update:->

    return if @_pin

    @vx += @ax
    @vy += @ay

    @vx *= @spring
    @vy *= @spring

    @x = @x + @vx
    @y = @y + @vy

    @ax = 0
    @ay = 0

  draw:->

    super

  pin:->
    @_pin = true