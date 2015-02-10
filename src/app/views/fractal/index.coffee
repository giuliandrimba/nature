AppView = require 'app/views/app_view'
Draw = require "draw/draw"
LSystem = require "./l_system"
Turtle = require "./turtle"
Rule = require "./rule"

module.exports = class Index extends AppView

	destroy:=>
		@ctx?.clear()
		@ctx?.destroy()
		super

	after_render:=>

		@ctx?.clear()
		@ctx?.destroy()

		@ctx = window.Sketch.create

			container:@el.get(0)
			lsys: undefined
			turtle: undefined
			ruleset: []

			pressing: false

			setup:->

				Draw.CTX = $(".sketch").get(0).getContext("2d")

				@ruleset[0] = new Rule "F", "FF+[+F-F-F]-[-F+F+F]"
				@lsys = new LSystem "F", @ruleset

				@turtle = new Turtle @lsys.sentence, 100, 25


			update:->

			mouseup:->

				@generate()

			generate:->

				@turtle.set_todo @lsys.generate(), (@turtle.len / 3)


			draw:->
				Draw.CTX.save()
				Draw.CTX.translate @width/2, @height - 80
				Draw.CTX.rotate -Math.PI/2
				@turtle.draw Draw.CTX
				Draw.CTX.restore()

