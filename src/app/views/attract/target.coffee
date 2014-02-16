Ball = require "./ball"
Calc = require "draw/math/calc"

module.exports = class Target extends Ball

  attract:(b)->

    angle = Calc.ang @x, @y, b.x, b.y
    rad = Calc.deg2rad angle

    f = {}

    f.x = Math.cos rad
    f.y = Math.sin rad

    dist = Calc.dist @x, @y, b.x, b.y

    if dist > 25
      dist = 25

    if dist < 15
      b.collided = true
      dist = 15

    g = (@mass * b.mass) / (dist * dist)

    f.x *= g
    f.y *= g

    f.x *= -1
    f.y *= -1

    return f

