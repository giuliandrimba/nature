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

  max_speed: 7
  max_force: 0.2

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

    # @max_speed = 6 + (Math.random() * 5)
    # @max_force = 0.1 + Math.random()

    super

  draw:->
    super

    # @ctx.fillStyle = "#fff"
    # @ctx.beginPath()
    # @ctx.arc @target_loc.x, @target_loc.y, 10, 0, Math.PI*2,true
    # @ctx.closePath()
    # @ctx.fill()

    # @ctx.fillStyle = "#00ff00"
    # @ctx.beginPath()
    # @ctx.arc @target_loc.x, @target_loc.y, 4, 0, Math.PI*2,true
    # @ctx.closePath()
    # @ctx.fill()

    # @ctx.fillStyle = "#0000ff"
    # @ctx.beginPath()
    # @ctx.arc @predictLoc.x, @predictLoc.y, 2, 0, Math.PI*2,true
    # @ctx.closePath()
    # @ctx.fill()

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

    predict = Vector.copy @vel
    predict = Vector.normalize predict
    predict = Vector.mult predict, 50
    predictLoc = Vector.add @location(), predict

    normal = null
    target = null
    worldRecord = 100000

    i = 0
    while i < (path.points.length - 1)

      p = path.points

      a = p[i]
      b = p[i + 1]

      normalPoint = @_get_normal predictLoc, a, b

      if normalPoint.x < a.x or normalPoint.x > b.x

        normalPoint = b

      distance = Vector.dist predictLoc, normalPoint

      if distance < worldRecord

        worldRecord = distance
        normal = normalPoint

        dir = Vector.sub a, b
        dir = Vector.normalize dir
        dir = Vector.mult dir, 10
        target = normalPoint
        target = Vector.add target, dir
        @target_loc = target

      i++


    # if worldRecord > (path.h / 2)

    @seek target

  _get_normal:(p, a, b)->

    ap = Vector.sub p, a
    ab = Vector.sub b, a
    ab = Vector.normalize ab
    ab = Vector.mult ab, Vector.dot(ap, ab)
    normalPoint = Vector.add a, ab
    normalPoint

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

    if Vector.mag(desired) is 0
      return

    desired = Vector.normalize desired
    desired = Vector.mult desired, @max_speed

    steer = Vector.sub desired, @vel
    # console.log "----------------"
    # console.log steer
    # console.log "+++++"
    steer = Vector.limit steer, @max_force
    # console.log steer
    # console.log "----------------"

    @apply_force steer

  location:->

    l =
      x:@x
      y:@y

