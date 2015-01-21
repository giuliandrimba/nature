module.exports = class Cell

  x:0
  y:0
  state: 0
  color: "#fff"

  constructor:(@x, @y)->

  update:->

  draw:(ctx)->

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



