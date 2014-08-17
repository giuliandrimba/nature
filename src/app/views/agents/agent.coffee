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

  max_speed: 10
  max_force: 0.5

  vel:
    x: 0
    y: 0

  constructor:()->
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
    @ctx.strokeWidth = 10
    @ctx.moveTo @x,  @y
    @ctx.lineTo @target_loc.x, @target_loc.y
    @ctx.stroke()

  follow:(path)->

    predict = Vector.normalize @vel
    predict = Vector.mult predict, 25
    predictLoc = Vector.add @location(), predict

    path_start = Vector.new()
    path_start.x = path.x
    path_start.y = path.y + (25 / 2)

    path_end = Vector.new()
    path_end.x = path.x + path.w
    path_end.y = path.y + (25 / 2)

    a = Vector.sub predictLoc, path_start
    b = Vector.sub path_end, path_start

    b = Vector.normalize b
    b = Vector.mult b, Vector.dot(a, b)

    @normal_point = Vector.add path_start, b

    distance = Vector.dist predictLoc, @normal_point

    b = Vector.normalize b
    b = Vector.mult b, 25

    @target_loc = Vector.add @normal_point, b

    if distance > path.h / 2

      @seek @target_loc

  _get_normal:(p, a, b)->

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

