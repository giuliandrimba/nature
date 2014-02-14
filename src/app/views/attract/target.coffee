Ball = require "./ball"
Calc = require "draw/math/calc"

module.exports = class Target extends Ball

  attract:(b)->

    angle = Calc.ang @x, @y, b.x, b.y
    rad = Calc.deg2rad angle

    # console.log rad

    f = {}

    f.x = Math.cos rad
    f.y = Math.sin rad

    dist = Calc.dist @x, @y, b.x, b.y

    if dist > 500
      dist = 500

    if dist < 10
      dist = 10

    g = (@mass * b.mass) / (dist * dist)

    f.x *= g
    f.y *= g

    return f

