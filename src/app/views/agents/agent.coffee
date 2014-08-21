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

    # predict = Vector.normalize @vel
    # predict = Vector.mult predict, 25
    # predictLoc = Vector.add @location(), predict

    # @ctx.fillStyle = "#fff"
    # @ctx.beginPath()
    # @ctx.arc @target_loc.x, @target_loc.y, 10, 0, Math.PI*2,true
    # @ctx.closePath()
    # @ctx.fill()

    @ctx.fillStyle = "#00ff00"
    @ctx.beginPath()
    @ctx.arc @target_loc.x, @target_loc.y, 4, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()

    @ctx.fillStyle = "#0000ff"
    @ctx.beginPath()
    @ctx.arc @predictLoc.x, @predictLoc.y, 2, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()

  is_in_path:(vector, path_start, path_end)->

    if path_start.x >= path_end.x

      if vector.x > path_start.x || vector.x < path_end.x
        return false

    else if path_start.x <= path_end.x

      if vector.x < path_start.x || vector.x > path_end.x
        return false

    if path_start.y >= path_end.y

      if vector.y > path_start.y || vector.y < path_end.y
        return false

    else if path_start.y <= path_end.y

      if vector.y < path_start.y || vector.y > path_end.y
        return false

    return true

  follow:(path)->

    v = Vector.copy @vel
    predict = Vector.normalize v
    predict = Vector.mult predict, 25
    predictLoc = Vector.add @location(), predict
    @predictLoc = predictLoc

    is_in_path = false

    i = 0

    @path_distance = 10000

    while i < 10

      if i < (path.points.length - 1)

        path_start = path.points[i + 1]
        path_end = path.points[i]

        norm = @_get_normal(predictLoc, path_start, path_end)
        distance = Vector.dist predictLoc, norm.normal

        if @is_in_path(norm.normal, path_start, path_end)
          is_in_path = true        

        if distance < @path_distance and is_in_path is true

          @normal_point = norm.normal
          @current_norm = norm
          @path_distance = distance

        else

          @normal_point = path_end
          @current_norm = norm
          @path_distance = distance

        b = Vector.normalize @current_norm.path
        b = Vector.mult b, 25

        if is_in_path
          break

      i++


    @target_loc = Vector.add @normal_point, b

    if distance > path.h / 2
      @seek @target_loc

  _get_normal:(p, a, b)->

    ap = Vector.sub p, a
    ab = Vector.sub b, a

    ab = Vector.normalize ab
    ab = Vector.mult ab, Vector.dot(ap, ab)

    {normal: (Vector.add a, ab), path:ab}

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

