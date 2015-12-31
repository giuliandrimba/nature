Calc = require("app/lib/draw/math/calc")

module.exports = class Neuron

  connections: undefined

  sum: 0

  radius: 32
  location: {}
  index: undefined

  constructor:(x, y)->
    @connections = []
    @radius = 32
    @sum = 0
    @location = {}
    @location.x = x
    @location.y = y

  add_connection:(c)->
    @connections.push c

  feedforward:(input)->
    @sum += input

    if(@sum >= 1)
      @fire()
      @sum = 0

  fire:->
    @radius = 64

    for c in @connections
      c.feedforward @sum

  draw:(ctx)->
    color = Math.round(Calc.map(@sum, 0, 1, 0, 255))
    ctx.fillStyle = "rgba(#{color},#{color},#{color}, 1)"
    ctx.lineWidth = 1
    ctx.strokeStyle = "#fff"
    ctx.beginPath()
    ctx.arc @location.x, @location.y, @radius, 0, Math.PI*2,true
    ctx.closePath()
    ctx.fill()
    ctx.stroke()

    if @index is 1
      console.log color

    @radius = Calc.lerp(@radius, 32, 0.1)
