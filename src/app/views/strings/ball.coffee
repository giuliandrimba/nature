Circle = require "draw/geom/circle"

module.exports = class Ball extends Circle

  x: 0
  y: 0
  vx: 0
  vy: 0
  _pin: false

  constructor:->
    super 
    @mass = @radius

  pos:(x, y)->
    @x = @old_x = x
    @y = @old_y = y

  apply_force:(fx, fy)->

    return if @_pin

    @x += fx
    @y += fy

  update:->

    return if @_pin

    tmp_x = @x
    tmp_y = @y

    @x += @x - @old_x
    @y += @y - @old_y

    @old_x = tmp_x
    @old_y = tmp_y

  draw:->

    super

  pin:->
    @_pin = true