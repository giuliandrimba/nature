Connection = require("./connection")
Neuron = require("./neuron")

module.exports = class Network

  neurons: undefined
  connections: undefined
  location: {}

  constructor:(x, y)->
    @location.x = x
    @location.y = y
    @neurons = []
    @connections = []
    @midis = []
    _ = @


  add_neuron:(n)=>
    n.audio = @synth
    @neurons.push n
    n.index = @neurons.length

  connect:(a, b, weight)=>
    c = new Connection a, b, weight
    a.add_connection c
    @connections.push c

  feedforward:(input)=>
    start = @neurons[0]
    start.feedforward input

  get_audio:->

  update:()=>

    for c in @connections
      c.update()

  draw:(ctx)=>
    ctx.save()
    ctx.translate(@location.x, @location.y)

    for n in @neurons
      n.draw(ctx)


    for c in @connections
      c.draw(ctx)

    # ctx.strokeStyle = "rgba(255,255,255,0.2)"
    # ctx.lineWidth = 1
    # for c in @connections
    #   ctx.moveTo c.a.location.x, c.a.location.y
    #   ctx.lineTo c.b.location.x, c.b.location.y

    # ctx.stroke()
    ctx.restore()

