PIXI = require "pixi"

module.exports = class Ball extends PIXI.Graphics

  constructor:(@x, @y, @radius)->
    super

  setup:->

  update:->

  draw:->

    @beginFill 0xFFFFFF
    @moveTo @x, @y
    @drawCircle  @x, @y, @radius
    @endFill()

    @beginFill()
    @lineStyle 1, 0x000000, 1
    @moveTo @x, @y
    @lineTo Math.round(@x - 3), Math.round(@y - 3)
    @moveTo @x,  @y
    @lineTo Math.round(@x + 3), Math.round(@y + 3)
    @moveTo @x,  @y
    @lineTo Math.round(@x + 3), Math.round(@y - 3)
    @moveTo @x,  @y
    @lineTo Math.round(@x - 3), Math.round(@y + 3)
    @endFill()


