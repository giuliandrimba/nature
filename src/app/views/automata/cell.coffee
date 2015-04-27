scale = require "app/lib/scale"
Calc = require "draw/math/calc"
Circle = require "draw/geom/circle"

module.exports = class Cell extends Circle

  x:0
  y:0
  state: 0
  previous: 0
  color: "#fff"

  radius: 40

  drawed: false

  iddle_x: 0
  iddle_y: 0
  vx:0
  vy:0
  ac:0
  spring:0.2
  ax:0
  ay:0
  speed:0.2
  friction:0.9

  constructor:(@state, @x, @y)->
    @iddle_x = @x
    @iddle_y = @y
    @previous = @state

    @offsetX = $("canvas").offset().left
    @offsetY = $("canvas").offset().top

    super 1, "#fff"


  draw:(ctx, sketch)->

    if @state is 0
      @opacity = 0
      @radius = 1

    if @state is 1
      @opacity = 1
      @radius += 0.1
      if @radius > 3
        @radius = 3

    super




