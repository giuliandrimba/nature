AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Network = require "./network"
Neuron = require "./neuron"

module.exports = class Index extends AppView

  destroy:=>
    @ctx?.clear()
    @ctx?.destroy()
    super

  after_render:=>
    setTimeout @init, 1500

  init:=>

    @ctx?.clear()
    @ctx?.destroy()

    @ctx = window.Sketch.create

      container: @el.find(".neural").get(0)
      network: undefined
      frame_count:0

      resize:->
        @draw()

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @network = new Network @width / 2, @height / 2
        @frame_count = 0

        a = new Neuron -275, 0
        b = new Neuron -150, 0
        c = new Neuron 0, 75
        d = new Neuron 0, -75
        e = new Neuron 150, 0
        f = new Neuron 275, 0

        @network.connect a, b, 1
        @network.connect b, c, Math.random()
        @network.connect b, d, Math.random()
        @network.connect c, e, Math.random()
        @network.connect d, e, Math.random()
        @network.connect e, f, 1

        @network.add_neuron a
        @network.add_neuron b
        @network.add_neuron c
        @network.add_neuron d
        @network.add_neuron e
        @network.add_neuron f

      update:->

        @network.update()

        @frame_count++

        if @frame_count % 60 is 0
          @frame_count = 0
          @network.feedforward Math.random()



      mouseup:->

      draw:->
        @network.draw(Draw.CTX)

