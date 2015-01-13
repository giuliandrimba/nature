Rect = require "draw/geom/rect"
Calc = require "draw/math/calc"

module.exports = class KeyPoint extends Rect

  mouse: undefined
  over: true
  vw: 0.1
  target: 0

  update:(mouse)=>

    dist = Calc.dist mouse.x, mouse.y, @x, @y

    if dist < 300

      @target = 10 * ((300 - dist) / 100)

    else

      @target = 5

    vw = (@width - @target) * 0.5

    @radius = Math.abs(vw)
    @width = vw
    @height = vw
