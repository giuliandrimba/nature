Calc = require("app/lib/draw/math/calc")

module.exports = class Neuron

  connections: undefined

  sum: 0

  radius: 5
  location: {}
  index: undefined
  audio_code: 0

  vx: 0
  vy: 0
  dx: 0
  dy: 0
  ax: 0.1
  ay: 0.1
  friction: 0.9
  spring: 0.2
  speed: 0.1

  constructor:(@x, @y, audio_code)->
    @connections = []
    @radius = 5
    @sum = 0
    @speed = Math.random() / 50
    @spring = Math.random() / 50
    @location = {}
    @location.x = @x + Math.random() * 10
    @location.y = @y + Math.random() * 10
    @audio_code = audio_code

  add_connection:(c)->
    @connections.push c

  preload_sound:=>
    window.T.soundfont.preload [@audio_code]

  feedforward:(input)->
    @sum += input

    if(@sum >= 1)
      @fire()
      @sum = 0

  fire:->
    @radius = 20
    window.T.soundfont.play(@audio_code);

    for c in @connections
      c.feedforward @sum

  change_position:=>
    sr = (100 * $(window).width()) / 1440
    r = (150 * $(window).width()) / 1440

    ang = Math.random() * 360
    rad = Calc.deg2rad ang
    @x =  Math.sin(rad) * (sr + (Math.random() * r))
    @y =  Math.cos(rad) * (sr + (Math.random() * r))
    @animating = true

  draw:(ctx)->

    if @animating
      @location.x += (@x - @location.x) * 0.2
      @location.y += (@y - @location.y) * 0.2

      if Math.round(@location.x) is Math.round(@x) and Math.round(@location.y) is Math.round(@y)
        @animating = false
        @x = @x + Math.random() * 10
        @y = @y + Math.random() * 10
    else

      @dx = @x - @location.x
      @dy = @y - @location.y

      @ax = @dx * @spring
      @ay = @dy * @spring

      @vx += @ax
      @vy += @ay

      @location.x += @vx * @speed
      @location.y += @vy * @speed


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
