AppView = require 'app/views/app_view'
Draw = require "draw/draw"
LSystem = require "./l_system"
Turtle = require "./turtle"
Rule = require "./rule"
systems = require "./systems"
Calc = require "app/lib/draw/math/calc"

module.exports = class Index extends AppView

  title: "Natura : Chaotic Shapes"

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

      container: @el.find(".fractals").get(0)
      lsys: undefined
      turtle: undefined
      ruleset: []
      theta: 90

      turtle: undefined

      pressing: false
      fullscreen: true

      resize:->
      	@draw()

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d")
        @create_sys()

      create_sys:->
        @sys = systems.get_sys()
        @ruleset[0] = new Rule "F", @sys.rule
        @lsys = new LSystem @sys.axiom, @ruleset
        @turtle = new Turtle @lsys, @sys.len, @sys.theta, @sys.n

      update:->

        @turtle.update()

      mouseup:->

        @create_sys()

      draw:->
        rad = Calc.deg2rad @theta

        Draw.CTX.save()
        Draw.CTX.translate @width/2 + @sys.x, (@height/2) - 120 + @sys.y
        Draw.CTX.rotate -rad
        @turtle.draw Draw.CTX
        Draw.CTX.restore()
        console.log "DRAW"

