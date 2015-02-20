AppView = require 'app/views/app_view'
Draw = require "draw/draw"
LSystem = require "./l_system"
Turtle = require "./turtle"
Rule = require "./rule"
systems = require "./systems"
Calc = require "app/lib/draw/math/calc"

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
			theta: 90

			turtles: []

			pressing: false

			setup:->

				Draw.CTX = $(".sketch").get(0).getContext("2d")

				@create_sys()

			create_sys:->
				@sys = systems.get_sys()
				@ruleset[0] = new Rule "F", @sys.rule
				@lsys = new LSystem @sys.axiom, @ruleset
				theta = @sys.theta
				@turtles.push new Turtle @lsys, @sys.len, @sys.theta, @sys.n
				# @turtles.push new Turtle @lsys, @sys.len, @sys.theta, @sys.n
				# @turtles.push new Turtle @lsys, @sys.len, @sys.theta, @sys.n
				# @turtles.push new Turtle @lsys, @sys.len, @sys.theta, @sys.n

			update:->

				# @theta += 0.1

				for t in @turtles
					t.update()

			mouseup:->

				@generate()

			generate:->


			draw:->
				rad = Calc.deg2rad @theta
				count = 1
				Draw.CTX.save()
				Draw.CTX.translate @width/2 + @sys.x, @height/2 + @sys.y
				for t, i in @turtles
					Draw.CTX.rotate -rad * count
					t.draw Draw.CTX
					count++
				Draw.CTX.restore()

