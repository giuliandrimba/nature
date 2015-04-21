scale = require "app/lib/scale"
Calc = require "draw/math/calc"

module.exports = class Cell

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

  constructor:(@state, @x, @y, img)->
    @iddle_x = @x
    @iddle_y = @y
    @previous = @state

    @size = scale img.width, img.height, $(window).width(), $(window).height()
    img.width = @size.width
    img.height = @size.height

    @offsetX = $("canvas").offset().left
    @offsetY = $("canvas").offset().top
    @img1 = img


  draw:(ctx, img, sketch)->

    ctx.save()


    ctx.beginPath()

    if @state is 0
      ctx.fillStyle = "#000"

    ctx.rect(@x, @y, @radius, @radius);

    if @state is 0
      ctx.fill()

    ctx.closePath()
    ctx.clip()

    if !@drawed

      @drawed = true

    if @state is 1
      ctx.drawImage @img1, -@offsetX, -@offsetY, @img1.width, @img1.height

    ctx.restore()




