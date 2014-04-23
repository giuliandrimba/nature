Calc = require "draw/math/calc"

module.exports = class String

  p1: {}
  p2: {}
  dist: 30

  constructor:(@p1, @p2, @dist)->



  update:->

    dx = @p2.x - @p1.x
    dy = @p2.y - @p1.y

    dist = Calc.dist @p2.x, @p2.y, @p1.x, @p1.y

    diff = (@dist - dist)

    fx = (diff * dx / dist) * 0.5
    fy = (diff * dy / dist) * 0.5

    @p2.apply_force fx, fy
    @p1.apply_force -fx, -fy



