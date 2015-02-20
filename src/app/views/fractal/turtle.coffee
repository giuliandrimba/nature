Calc = require "app/lib/draw/math/calc"

module.exports = class Turtle

	todos: []

	len: 0
	theta: 0
	ang: 0
	old_ang: 0
	old_x: 0
	old_y: 0
	y: 0
	x: 0
	points: []

	constructor:(@lsys, @len, @theta, @iterations)->

		@todos = []
		@y = 0
		@run()

	run:->

		i = 0

		@lsys.reset()

		while i < @iterations

			@set_todo @lsys.generate(), (@len / 1.1)
			i++

	update:->

		# @theta += 0.01

	draw:(ctx)->

		ctx.beginPath()
		ctx.moveTo 0, 0
		@ang = 0
		@x = 0
		@y = 0
		@old_x = 0
		@old_y = 0

		$.map @todos, (todo, i)=>

			for c, i in todo.s

				if c is "F" or c is "G"
					@points.push
						x:@x
						y:@y
					ctx.lineTo @x, @y
				else if c is "+"
					@ang += @theta
					rad = Calc.deg2rad @ang
					@old_x = @x
					@old_y = @y
					@x += (Math.cos(rad) * todo.l)
					@y += (Math.sin(rad) * todo.l)
				else if c is "-"
					@ang -= @theta
					rad = Calc.deg2rad @ang
					@old_x = @x
					@old_y = @y
					@x = @x + (Math.cos(rad) * todo.l)
					@y = @y + (Math.sin(rad) * todo.l)
				else if c is "["
					@ang += @theta
				else if c is "]"
					@ang -= @theta

		ctx.strokeStyle = "#ffffff";
		ctx.lineWidth = 2;
		ctx.stroke()
		ctx.closePath()

	set_todo:(todo, length)->
		@len = length
		@todos = []
		@todos.push s:todo, l:@len

