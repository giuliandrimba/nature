Circle = require "draw/geom/circle"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Pivot extends Circle

  vx: 0
  vy: 0
  ax: 0
  ay: 0
  spring: 0.8
  target: {}
  angle: 0
  rotate: true
  speed: 0.1

  constructor:(@target)->

    super 0, "#FF0000"
    @x = @target.x
    @y = @target.y

  update:->

    if @speed < 0
      @speed = 0.01

    @ax = @target.x - @x
    @ay = @target.y - @y

    if @ax < 50 or @ay < 50

      if @rotate

        rad = Calc.deg2rad @angle
  
        @ax += (Math.cos rad) * 30
        @ay += (Math.sin rad) * 30
  
        @angle += 5


    @vx += @ax * @speed
    @vy += @ay * @speed

    @vx *= @spring
    @vy *= @spring

    @x += @vx
    @y += @vy