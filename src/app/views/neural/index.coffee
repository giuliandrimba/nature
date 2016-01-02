AppView = require 'app/views/app_view'
Draw = require "draw/draw"
Network = require "./network"
Neuron = require "./neuron"
Calc = require("app/lib/draw/math/calc")

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
        @network.location.x = @width / 2
        @network.location.y = @height / 2
        @draw()

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @network = new Network @width / 2, @height / 2
        @frame_count = 0
        window.T.soundfont.setInstrument(5);

        @create_neurons()

      create_neurons:->

        i = 0
        total = 127

        while i < total
          ang = Math.random() * 360
          rad = Calc.deg2rad ang
          x =  Math.sin(rad) * (100 + (Math.random() * 150))
          y =  Math.cos(rad) * (100 + (Math.random() * 150))
          a = new Neuron x, y, Math.round(Math.random() * total)
          @neurons.push a
          i++

        i = 0
        while i < total
          if i > 0
            a = @neurons[i - 1]
            b = @neurons[i]
            if i < total - 1
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
          @network.feedforward 1



      mouseup:->
        window.T.soundfont.setInstrument(Math.round(Math.random() * 127));


      draw:->
        Draw.CTX.fillStyle = "rgba(0,0,0,1)"
        Draw.CTX.fillRect(0, 0, @width, @height)
        @network.draw(Draw.CTX)
