Calc = require("app/lib/draw/math/calc")

module.exports = class Connection

  a: undefined
  b: undefined
  weight: undefined
  sender: undefined

  sending: false
  output: 0

  constructor:(from, to, w)->
    @sender = {}
    @output = 0
    @sending = false
    @weight = w
    @a = from
    @b = to

  feedforward:(val)=>
    @output = val * @weight
    @sender.x = @a.location.x
    @sender.y = @a.location.y
    @sending = true
    @b.preload_sound()

  update:=>
    if @sending
      @sender.x = Calc.lerp(@sender.x, @b.location.x, 0.1)
      @sender.y = Calc.lerp(@sender.y, @b.location.y, 0.1)

      d = Calc.dist(@sender.x, @sender.y, @b.location.x, @b.location.y)

      if d < 1
        @b.feedforward(@output)
        @sending = false

  draw:(ctx)=>
    # ctx.strokeStyle = "#ffffff"
    # ctx.lineWidth = 1+@weight
    # ctx.moveTo @a.location.x, @a.location.y
    # ctx.lineTo @b.location.x, @b.location.y
    # ctx.stroke()

    if @sending
      ctx.fillStyle = "#fff"
      ctx.lineWidth = 1
      ctx.beginPath()
      ctx.arc @sender.x, @sender.y, 5, 0, Math.PI*2,true
      ctx.closePath()
      ctx.fill()


