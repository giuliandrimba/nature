Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"
Draw = require("draw/draw")

module.exports = class Target extends Circle

  vx:0
  vy:0
  speed:1
  dx:0
  dy:0
  spring:0.2
  ax:0
  ay:0
  friction:0.7

  constructor:()->
    super

  set_target:(@target_x, @target_y)->

  update:()->

    @dx = @target_x - @x
    @dy = @target_y - @y
    @ax = @dx * @spring
    @ay = @dy * @spring
    @vx += @ax
    @vy += @ay

    @vx *= @friction
    @vy *= @friction
    @x += @vx * @speed
    @y += @vy * @speed

    @target_angle = Calc.ang @x, @y, @target_x, @target_y
    @target_angle = Calc.deg2rad @target_angle
    @target_dist = Calc.dist @x,@y,@target_x,@target_y
    @anx = Math.cos @target_angle
    @any = Math.sin @target_angle

  draw:()->
    super
    @ctx.strokeStyle = "#000000"
    @ctx.strokeWidth = 1
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x - 3), Math.round(@y - 3)
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x + 3), Math.round(@y + 3)
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x + 3), Math.round(@y - 3)
    @ctx.moveTo @x,  @y
    @ctx.lineTo Math.round(@x - 3), Math.round(@y + 3)
    @ctx.stroke()

    radiusx = @radius
    radiusy = @radius

    if @target_dist < @radius
      radiusx = @target_dist
      radiusy = @target_dist


    x = @x + (@anx * radiusx)
    y = @y + (@any * radiusy)
    @ctx.beginPath()
    @ctx.strokeStyle = "#000000"
    @ctx.strokeWidth = 1
    @ctx.moveTo @x, @y
    @ctx.lineTo x, y
    @ctx.stroke()
    @ctx.closePath()
    @ctx.beginPath()
    @ctx.strokeStyle = "#ffffff"
    @ctx.moveTo x, y
    @ctx.lineTo @target_x, @target_y
    @ctx.stroke()
    @ctx.closePath()

    
