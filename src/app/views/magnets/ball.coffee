Circle = require "draw/geom/circle"
Draw = require "draw/draw"

module.exports = class Ball extends Circle

  x: 0
  y: 0
  mass: 0
  vx: 0
  vy: 0
  ax: 0
  ay: 0
  speed: 1
  collided: false

  constructor:->
    super
    @mass = @radius

  apply_force:(fx, fy)->

    @ax += fx
    @ay += fy

  update:->

    @vx += @ax
    @vy += @ay

    if @vx > 2.4
      @vx = 2.4

    if @vy > 2.4
      @vy = 2.4


    @ax = 0
    @ay = 0

  draw:->

    @x += @vx * @speed
    @y += @vy * @speed

    super

    @ctx.fillStyle = "#FFF"
    @ctx.beginPath()
    @ctx.arc @x, @y, @radius / 10, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()
    