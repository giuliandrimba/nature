Calc = require "draw/math/calc"

module.exports = class String

  p1: {}
  p2: {}
  dist: 10

  constructor:(@p1, @p2, @dist)->



  update:->

    dx = @p2.x - @p1.x
    dy = @p2.y - @p1.y

    dist = Calc.dist @p2.x, @p2.y, @p1.x, @p1.y

    diff = (30 - dist) / dist

    fx = dx * 0.5 * diff
    fy = dy * 0.5 * diff

    @p2.apply_force fx, fy



