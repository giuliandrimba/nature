Circle = require "draw/geom/circle"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Particle extends Circle

  dx: 0 # X direction
  dy: 0 # Y direction

  mag: 1
  dist: 0
  pivot: {}

  constructor:(@pivot, @dx, @dy)->

    super 1, "#fff"

  update:->

    @old_x = @x
    @old_y = @y

    vx = @pivot.x + @dx
    vy = @pivot.y + @dy

    @x = vx
    @y = vy

    if Math.abs(@x - @old_x) > 1
      @opacity = 0.9

    @dist = Calc.dist @pivot.x, @pivot.y, @x, @y

    @radius = @dist / 100 * @mag
    @opacity = 1 - (@dist / 100 / 3.2)

    if @opacity < 0
      @opacity = 0
