scale = require "app/lib/scale"

module.exports = class Cell

  x:0
  y:0
  state: 0
  previous: 0
  color: "#fff"

  radius: 5

  drawed: false

  constructor:(@state, @x, @y, img)->
    @previous = @state

    @size = scale img.width, img.height, $(window).width(), $(window).height()
    img.width = @size.width
    img.height = @size.height

  update:->

  draw:(ctx, img, sketch)->
    if @state is 1
      @color = "#666"
    else
      @color = "#111"

    ctx.save()


    ctx.beginPath()
    if @state is 0
      ctx.fillColor = "#666"
    ctx.arc(@x, @y, @radius, 0, 2 * Math.PI, false);
    if @state is 0
      ctx.fill()
    ctx.closePath()
    ctx.clip()

    if !@drawed

      @drawed = true

    img1 = document.getElementById "automata-img"
    # ctx.drawImage img, @x - 7, @y - 6, @size.width, @size.height, @x - 7, @y - 6, 20, 20
    if @state is 1
      ctx.drawImage img1, 0, 0

    ctx.restore()




