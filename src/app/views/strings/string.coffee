Calc = require "draw/math/calc"

module.exports = class String

  p1: {}
  p2: {}
  dist: 10

  constructor:(@p1, @p2, @dist)->



  update:->

    dx = @p2.x - @p1.x
    dy = @p2.y - @p1.y

    fx = -1 * dx * 0.5
    fy = -1 * dy * 0.5

    @p2.apply_force fx, fy



