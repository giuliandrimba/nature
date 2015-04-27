Rect = require "draw/geom/rect"
Calc = require "draw/math/calc"

module.exports = class KeyPoint extends Rect

  mouse: undefined
  over: true
  vw: 0.1
  target: 0

  update:(mouse, radius)=>

    dist = Calc.dist mouse.x, mouse.y, @x, @y

    if dist < 300

      @target = (radius * 0.05) * ((300 - dist) / 100)

    else

      @target = 0

    vw = (@width - @target) * 0.2

    @radius = Math.abs(vw)
    @width = vw
    @height = vw
