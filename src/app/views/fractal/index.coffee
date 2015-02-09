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

				@ruleset[0] = new Rule "A", "ABA"
				@ruleset[1] = new Rule "B", "BBB"
				@lsys = new LSystem "A", @ruleset

				@turtle = new Turtle @lsys.sentence, 600, 25


			update:->

			mouseup:->

				@generate()

			generate:->

				@turtle.set_todo @lsys.generate(), (@turtle.len / 3)


			draw:->
				Draw.CTX.save()
				Draw.CTX.translate 200, 200
				@turtle.draw Draw.CTX
				Draw.CTX.restore()

