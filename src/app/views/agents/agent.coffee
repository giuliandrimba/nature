Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"
Vector = require "./vector"

module.exports = class Agent extends Circle

  fx: 0
  fy: 0
  ang: 0
  speed: 0.1

  acc: 
    x: 0
    y: 0

  max_speed: 4
  max_force: 0.1

  vel:
    x: 0
    y: 0

  constructor:->
    @ang = Math.random() * 360
    @rad = Calc.deg2rad @ang

    @vel.x = (Math.cos @rad)
    @vel.y = (Math.sin @rad)

    super

  draw:->
    super

    predict = Vector.normalize @vel
    predict = Vector.mult predict, 25
    predictLoc = Vector.add @location(), predict

    @ctx.strokeStyle = "#0000ff"
    @ctx.strokeWidth = 2
    @ctx.moveTo @x,  @y
    @ctx.lineTo predictLoc.x, predictLoc.y
    @ctx.stroke()

  update:->

    @vel = Vector.add @vel, @acc

    @vel = Vector.limit @vel, @max_speed

    @x += @vel.x
    @y += @vel.y

    @acc = Vector.mult @acc, 0

  apply_force:(force)->

    @acc = Vector.add @acc, force

  seek:(target)->

    desired = Vector.sub target, @location()

    desired = Vector.normalize desired
    desired = Vector.mult desired, @max_speed

    steer = Vector.sub desired, @vel
    steer = Vector.limit steer, @max_force

    @apply_force steer

  location:->

    l = 
      x:@x
      y:@y

