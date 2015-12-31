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
      neurons: []
      frame_count:0

      resize:->
        @draw()

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @network = new Network @width / 2, @height / 2
        @frame_count = 0

        @create_neurons()

      create_neurons:->

        i = 0
        total = 50

        while i < total
          x =  Math.random() * (300 - (-300)) + (-300);
          y =  Math.random() * (300 - (-300)) + (-300);
          a = new Neuron x, y
          @neurons.push a
          i++

        i = 0
        while i < total
          a = @neurons[i]
          rndB = Math.round(Math.random() * (@neurons.length - 1))

          if rndB is i and rndB < total
            rndB++
          if rndB is i and rndB > 0
            rndB--
          rndC = Math.round(Math.random() * (@neurons.length - 1))
          if rndC is i and rndC < total
            rndC++
          if rndC is i and rndC > 0
            rndC--

          b = @neurons[rndB]
          c = @neurons[rndC]
          @network.connect a, b, Math.random()
          @network.connect a, c, Math.random()

          @network.add_neuron a
          i++



      update:->

        @network.update()

        @frame_count++

        if @frame_count % 60 is 0
          @frame_count = 0
          @network.feedforward Math.random()



      mouseup:->

      draw:->
        @network.draw(Draw.CTX)

