Circle = require "draw/geom/circle"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Particle extends Circle

  ox: 0 # Startint X position
  oy: 0 # Startint Y position
  dx: 0 # X direction
  dy: 0 # Y direction

  ax: 0
  ay: 0
  vx: 0
  vy: 0

  mag: 25
  speed: 0.1
  dir: 1
  dist: 0

  can_update: true

  constructor:(@ox, @oy, @dx, @dy)->

    super 1, "#fff"

    @x = @ox + (@dx * @mag)
    @y = @oy + (@dy * @mag)
    @dx = (@dx * @mag)
    @dy = (@dy * @mag)
    @vx = 0
    @vy = 0

  add_force:->

    @ax += @dx
    @ay += @dy

  update:->

    @dist = Calc.dist @ox, @oy, @x, @y
    @add_force()

    @vx += @ax
    @vy += @ay
    @x += @vx * @speed * @dir
    @y += @vy * @speed * @dir

    @ax = 0
    @ay = 0

    # @opacity = 1 - (@dist / 100 / 10)

    if @opacity < 0
      @opacity = 0

    @radius = @dist / 100 * 5

    if @radius > 20
      @stroke = "#000"
      @strokeWidth = 1

  is_dead:->


    if @dist > 2000

      return true

    # if @dist > 200
      # @dir = -1

    return false

