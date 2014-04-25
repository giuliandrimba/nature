Calc = require "draw/math/calc"
Draw = require "draw/draw"

module.exports = class String

  p1: {}
  p2: {}
  dist: 30

  constructor:(@p1, @p2)->

    @dist = Calc.dist @p1.x, @p1.y, @p2.x, @p2.y
    

  update:->

    dx = @p2.x - @p1.x
    dy = @p2.y - @p1.y

    dist = Calc.dist @p2.x, @p2.y, @p1.x, @p1.y

    diff = (@dist - dist) / dist

    fx = (diff * dx) * 0.5
    fy = (diff * dy) * 0.5

    @p1.apply_force -fx, -fy
    @p2.apply_force fx, fy


