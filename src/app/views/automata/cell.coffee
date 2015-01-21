module.exports = class Cell

  x:0
  y:0
  state: 0
  previous: 0
  color: "#fff"

  constructor:(@state, @x, @y)->
    @previous = @state

  update:->

  draw:(ctx)->
    if @state is 1
      @color = "#666"
    else
      @color = "#111"

    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.moveTo(@x - 3, @y - 6)
    ctx.lineTo(@x + 3, @y - 6)
    ctx.lineTo(@x + 7, @y)
    ctx.lineTo(@x + 3, @y + 6)
    ctx.lineTo(@x - 3, @y + 6)
    ctx.lineTo(@x - 7, @y)
    ctx.closePath()
    ctx.fill()



