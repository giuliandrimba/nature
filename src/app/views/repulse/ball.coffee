Circle = require "draw/geom/circle"
Calc = require "draw/math/calc"
Draw = require("draw/draw")

module.exports = class Ball extends Circle

  vx:0
  vy:0
  ac:0
  iddle_x:0
  iddle_y:0
  speed : 1
  dx:0
  dy:0
  spring:0.2
  ax:0
  ay:0
  speed:0.1
  friction:0.9
  run:false
  init_speed:0
  line_x:0
  line_y:0
  opacity:1

  constructor:()->
    super
    @speed = @init_speed = Math.random() * 0.1

  setup:(@ctx)->
    @init_x = @x
    @init_y = @y
    @iddle_x = @init_x + Math.random() * 10
    @iddle_y = @init_y + Math.random() * 10
    @target_x = @iddle_x
    @target_y = @iddle_y
    @max_rad = 15 + Math.random() * 40
    # @angle = Calc.ang @x,@y,@iddle_x,@iddle_y

  update:(@mouseX, @mouseY)->
    # console.log Calc.dist @x,@y,@iddle_x,@iddle_y
    # console.log Calc.ang @x,@y,@iddle_x,@iddle_y
    # @distance = Calc.dist @x,@y,@iddle_x,@iddle_y

    @mouse_dist = Calc.dist @x,@y,mouseX,mouseY

    if @mouse_dist < 150
      @speed = 0.2
      @spring=0.3
      mouse_angle = Calc.ang mouseX, mouseY, @iddle_x, @iddle_y
      mouse_angle = Calc.deg2rad mouse_angle
      dx = Math.cos mouse_angle
      dy = Math.sin mouse_angle
      @target_x = (mouseX + dx * 140)
      @line_x = (mouseX + dx * 70)
      @target_y = (mouseY + dy * 140)
      @line_y = (mouseY + dy * 70)
    else
      @spring=0.2
      @target_y = @iddle_y
      @target_x = @iddle_x

    if @mouse_dist > 200
      @speed = @init_speed

    if @mouse_dist < 230
      @radius = (@mouse_dist * 100) / 230
      @radius = @max_rad - (@radius * @max_rad) / 100
    else
      @radius = 1

    if @radius < 1
      @radius = 1


    @dx = @target_x - @x
    @dy = @target_y - @y
    @ax = @dx * @spring
    @ay = @dy * @spring

    @vx += @ax
    @vy += @ay

    if @vx > 1 or @vx < -1
      @vx *= @friction
    if @vy > 1 or @vy < -1
      @vy *= @friction

    @x += @vx * @speed
    @y += @vy * @speed

  draw:()->
    super


