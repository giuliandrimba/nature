AppView = require 'app/views/app_view'
Ball = require "./ball"
Magnet = require "./magnet"
Draw = require "draw/draw"

module.exports = class Index extends AppView

  magnets: []

  after_render:=>

    _ = @

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        _.ball = new Ball 20, "#000", "#fff", 4
        _.ball.x = @width / 2
        _.ball.y = @height / 2

        i = 0

        while i < 5

          m = new Magnet 25, "#FFF"
          m.x = Math.random() * @width
          m.y = Math.random() * @height
          _.magnets.push m
          i++


      update:->

        m.update() for m in _.magnets

        _.ball.update()

      draw:->

        m.draw() for m in _.magnets

        _.ball.draw()

