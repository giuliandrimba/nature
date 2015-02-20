AppView = require 'app/views/app_view'
Draw = require "draw/draw"
LSystem = require "./l_system"
Turtle = require "./turtle"
Rule = require "./rule"
systems = require "./systems"

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

				@create_sys()

			create_sys:->
				@sys = systems.get_sys()
				@ruleset[0] = new Rule "F", @sys.rule
				@lsys = new LSystem @sys.axiom, @ruleset
				@turtle = new Turtle @lsys, @sys.len, @sys.theta, @sys.n

			update:->

				@turtle.update()

			mouseup:->

				@generate()

			generate:->


			draw:->
				Draw.CTX.save()
				Draw.CTX.translate @width/2 + @sys.x, @height/2 + @sys.y
				Draw.CTX.rotate -Math.PI/2
				@turtle.draw Draw.CTX
				Draw.CTX.restore()

