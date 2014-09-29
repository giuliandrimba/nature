Circle = require "draw/geom/circle"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Particle extends Circle

  dx: 0 # X direction
  dy: 0 # Y direction

  mag: 1
  dist: 0
  pivot: {}

  cal_radius: false

  constructor:(@pivot, @dx, @dy)->

    super 1, "#fff"

  update:->

    vx = @pivot.x + @dx
    vy = @pivot.y + @dy

    @x = vx
    @y = vy

    unless @cal_radius

      @dist = Calc.dist @pivot.x, @pivot.y, @x, @y

      @radius = @dist / 100 * @mag

      if @radius > 2
        @radius = 4 - @radius

      @cal_radius = true