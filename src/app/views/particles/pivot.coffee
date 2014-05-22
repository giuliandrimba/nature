Circle = require "draw/geom/circle"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Pivot extends Circle

  vx: 0
  vy: 0
  ax: 0
  ay: 0
  spring: 0
  target: {}
  angle: 0

  constructor:(@target)->

    super 0, "#FF0000"
    @x = @target.x
    @y = @target.y

  update:->

    @ax = @target.x - @x
    @ay = @target.y - @y

    if @ax < 50 or @ay < 50

      rad = Calc.deg2rad @angle

      @ax += (Math.cos rad) * 10
      @ay += (Math.sin rad) * 10

      @angle += 10


    @vx += @ax * 0.1
    @vy += @ay * 0.1

    @vx *= 0.8
    @vy *= 0.8

    @x += @vx
    @y += @vy