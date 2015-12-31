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
      autoclear: false

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
          if i > 0
            a = @neurons[i - 1]
            b = @neurons[i]
            if i < total
              c = @neurons[i + 1]
              @network.connect a, c, Math.random()
            @network.connect a, b, Math.random()

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
        Draw.CTX.fillStyle = "rgba(0,0,0,1)"
        Draw.CTX.fillRect(0, 0, @width, @height)
        @network.draw(Draw.CTX)

