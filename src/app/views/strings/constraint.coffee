Calc = require "draw/math/calc"
Draw = require "draw/draw"

module.exports = class Constraint

  p1: {}
  p2: {}
  dist: 30

  constructor:(@p1, @p2)->

    @dist = Calc.dist @p1.x, @p1.y, @p2.x, @p2.y

  update:(is_mouse_down = false)->

    if is_mouse_down

      dx = @p2.x - @p1.x
      dy = @p2.y - @p1.y

      dist = Calc.dist @p2.x, @p2.y, @p1.x, @p1.y

      diff = (@dist - dist) / dist

      fx = (diff * dx) * 0.5
      fy = (diff * dy) * 0.5

      @p1.apply_force -fx, -fy
      @p2.apply_force fx, fy

    else

      dx = @p1.init_x - @p1.x
      dy = @p1.init_y - @p1.y
      @p1.apply_force dx * 0.001, dy * 0.001

      dx = @p2.init_x - @p2.x
      dy = @p2.init_y - @p2.y
      @p2.apply_force dx * 0.001, dy * 0.001


