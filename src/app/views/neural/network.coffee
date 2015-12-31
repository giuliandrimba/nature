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

  add_neuron:(n)=>
    @neurons.push n
    n.index = @neurons.length

  connect:(a, b, weight)=>
    c = new Connection a, b, weight
    a.add_connection c
    @connections.push c

  feedforward:(input)=>
    start = @neurons[0]
    start.feedforward input

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

    ctx.restore()

