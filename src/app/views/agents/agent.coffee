Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"

module.exports = class Agent extends Circle

  fx: 0
  fy: 0
  ang: 0
  speed: 0.1

  constructor:->
    @ang = Math.random() * 360
    @rad = Calc.deg2rad @ang

    @fx = Math.cos @rad
    @fy = Math.sin @rad

    super

  draw:->
    super

    @ctx.strokeStyle = "#000"
    @ctx.strokeWidth = 1
    @ctx.moveTo @x,  @y
    @ctx.lineTo @x + (@fx * 25), @y + (@fy * 25)
    @ctx.stroke()

  update:->

    @x += @fx * @speed
    @y += @fy * @speed

  set_direction:(@fx, @fy)->

  next_pos:->

    x: @x + (@fx * 25)
    y: @y + (@fy * 25)

  normalize:->


