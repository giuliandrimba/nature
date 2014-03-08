Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"

module.exports = class Magnet extends Circle

  dragged: false

  constructor:->
    super
    @mass = @radius * 2

  update:->

  attract:(ball)->

    deg = Calc.ang @x, @y, ball.x, ball.y
    rad = Calc.deg2rad deg
    distance = Calc.dist @x, @y, ball.x, ball.y

    if distance > 1000
      distance = 1000

    if distance < 250
      distance = 250

    strength = (@mass * ball.mass) / (distance * distance)
    fx = Math.cos(rad) * strength
    fy = Math.sin(rad) * strength

    if distance < 500
      ball.apply_force -fx, -fy

  draw:->
    super

    @ctx.fillStyle = "#000"
    @ctx.beginPath()
    @ctx.arc @x, @y, 1, 0, Math.PI*2, true
    @ctx.closePath()
    @ctx.fill()

