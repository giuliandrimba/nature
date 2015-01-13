Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"
Vector = require "./vector"

module.exports = class Agent extends Circle

  fx: 0
  fy: 0
  ang: 0
  speed: 0.1

  @FOLLOW_DIST: 50

  acc:
    x: 0
    y: 0

  max_speed: 3
  max_force: 0.2

  vel:
    x: 0
    y: 0

  path_distance: 10000

  logged: false

  desired_separation: 15
  sum:
    x: 0
    y: 0

  connections: []

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


    @ctx.strokeStyle = "rgba(255,255,255,0.1)"
    @ctx.lineWidth = 1
    @ctx.beginPath()

    for c in @connections

      @ctx.moveTo @x, @y
      @ctx.lineTo c.x, c.y

    @ctx.stroke()
    @ctx.closePath()


  avoid:(agents)=>

    count = 0
    @sum = Vector.new()
    steer = Vector.new()
    @connections = []

    for a in agents

      d = Vector.dist @location(), a.location()

      if d > 0 and d < @desired_separation

        diff = Vector.sub @location(), a.location()
        diff = Vector.normalize diff
        @connections.push a.location()
        @sum = Vector.add @sum, diff
        count++

    if count > 0

      @sum = Vector.div @sum, count
      @sum = Vector.normalize @sum
      @sum = Vector.mult @sum, @max_speed

      steer = Vector.sub @sum, @vel
      steer = Vector.limit steer, @max_force
      @apply_force steer

  is_in_path:(vector, path_start, path_end)->

    if path_start.x >= path_end.x

      if vector.x > path_start.x || vector.x < path_end.x
        vector = path_end

    else if path_start.x <= path_end.x

      if vector.x < path_start.x || vector.x > path_end.x
        vector = path_start

    if path_start.y >= path_end.y

      if vector.y > path_start.y || vector.y < path_end.y
        vector = path_end

    else if path_start.y <= path_end.y

      if vector.y < path_start.y || vector.y > path_end.y
        vector = path_start


  follow:(path)->

    predict = Vector.copy @vel
    predict = Vector.normalize predict
    predict = Vector.mult predict, Agent.FOLLOW_DIST
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
    steer = Vector.limit steer, 0.15
    # console.log steer
    # console.log "----------------"

    @apply_force steer

  location:->

    l =
      x:@x
      y:@y

