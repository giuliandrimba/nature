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

  path_distance: 10000

  logged: false

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

    @ctx.fillStyle = "#fff"
    @ctx.beginPath()
    @ctx.arc @target_loc.x, @target_loc.y, 10, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()

    @ctx.fillStyle = "#00ff00"
    @ctx.beginPath()
    @ctx.arc predictLoc.x, predictLoc.y, 10, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()

  follow:(path)->

    predict = Vector.normalize @vel
    predict = Vector.mult predict, 25
    predictLoc = Vector.add @location(), predict

    for p, i in path.points

      if i < path.points.length - 1

        path_start = p
        path_end = path.points[i + 1]
  
        @normal_point = @_get_normal(predictLoc, path_start, path_end)

        if @normal_point.x < path_start.x || @normal_point.x > path_end.x
          @normal_point = path_end

        distance = Vector.dist predictLoc, @normal_point

        if distance < @path_distance

          @path_distance = distance

          b = Vector.normalize @normal_point
          b = Vector.mult b, 25

          @target_loc = Vector.add @normal_point, b
  
    if distance > path.h / 2
      
      @seek @target_loc

    @logged = true

  _get_normal:(p, a, b)->

    ap = Vector.sub p, a
    ab = Vector.sub b, a

    ab = Vector.normalize ab
    ab = Vector.mult ab, Vector.dot(ap, ab)

    Vector.add a, ab

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

