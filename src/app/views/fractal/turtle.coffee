Calc = require "app/lib/draw/math/calc"

module.exports = class Turtle

	todos: []

	len: 0
	theta: 0
	y:0

	constructor:(todo, @len, theta)->

		@set_todo todo, @len
		@theta = Calc.deg2rad theta

	draw:(ctx)->

		ctx.beginPath()
		ctx.moveTo 0, 0
		x = 0
		y = 0

		$.map @todos, (todo, i)=>

			y = i * 30
			x = 0
			ctx.moveTo x, y

			for c, i in todo.s

				if c is "A"
					ctx.lineTo x + todo.l, y
					x += todo.l
				else if c is "B"
					x += todo.l
					ctx.moveTo x, y

		ctx.strokeStyle = "#ffffff";
		ctx.lineWidth = 10;
		ctx.stroke()
		ctx.closePath()

	set_todo:(todo, length)->
		@len = length
		@todos.push s:todo, l:@len

