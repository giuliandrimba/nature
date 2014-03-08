Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"

module.exports = class Target extends Circle

  constructor:->
    super 50, "#000", "#fff", 1
    @mass = 500

  update:->

  attract:(ball)->

    deg = Calc.ang @x, @y, ball.x, ball.y
    rad = Calc.deg2rad deg
    distance = Calc.dist @x, @y, ball.x, ball.y

    if distance > 750
      distance = 750

    if distance < 300
      distance = 300

    strength = (@mass * ball.mass) / (distance * distance)
    fx = Math.cos(rad) * strength
    fy = Math.sin(rad) * strength

    if distance < 500
      ball.apply_force -fx, -fy

  draw:->
    super

    @ctx.strokeStyle = "#fff"
    @ctx.strokeWidth = 1
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x - 3), Math.round(@y - 3)
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x + 3), Math.round(@y + 3)
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x + 3), Math.round(@y - 3)
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x - 3), Math.round(@y + 3)
    @ctx.stroke()

