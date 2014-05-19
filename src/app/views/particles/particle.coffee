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

  mag: 5
  speed: 0.1
  dir: 1

  constructor:(@ox, @oy, @dx, @dy)->

    super 1, "#fff"

    @x = @ox + (@dx * @mag)
    @y = @oy + (@dy * @mag)
    @vx = 0
    @vy = 0

  add_force:->

    @ax += @dx
    @ay += @dy

  update:->

    @vx += @ax
    @vy += @ay
    @x += @vx * @speed * @dir
    @y += @vy * @speed * @dir

    @ax = 0
    @ay = 0

  is_dead:->

    dist = Calc.dist @ox, @oy, @x, @y

    if dist < @mag

      return true

    if dist > 300
      @dir = -1

    return false

