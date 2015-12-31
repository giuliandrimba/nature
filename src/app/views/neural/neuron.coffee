Calc = require("app/lib/draw/math/calc")

module.exports = class Neuron

  connections: undefined

  sum: 0

  radius: 5
  location: {}
  index: undefined
  audio_code: 0

  constructor:(x, y, audio_code)->
    @connections = []
    @radius = 5
    @sum = 0
    @location = {}
    @location.x = x
    @location.y = y
    @audio_code = audio_code

  add_connection:(c)->
    @connections.push c

  feedforward:(input)->
    @sum += input

    if(@sum >= 1)
      @fire()
      @sum = 0

  fire:->
    @radius = 10
    window.T.soundfont.play(@audio_code);

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

    @radius = Calc.lerp(@radius, 5, 0.1)
