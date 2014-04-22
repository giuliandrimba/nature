Circle = require "draw/geom/circle"

module.exports = class Ball extends Circle

  x: 0
  y: 0
  mass: 0
  vx: 0
  vy: 0
  ax: 0
  ay: 0
  speed: 1

  constructor:->
    super 
    @mass = @radius

  draw:->

    @x += @vx * @speed
    @y += @vy * @speed

    super