Calc = require "app/lib/draw/math/calc"

module.exports = class Turtle

	todo: ""
	len: 0
	theta: 0
	y:0

	constructor:(@todo, @len, theta)->

		@theta = Calc.deg2rad theta

	draw:(ctx)->

		ctx.beginPath()
		ctx.moveTo 0, 0
		x = 0

		for c, i in @todo

			if c is "A"
				ctx.lineTo x + @len, 0
			else if c is "B"
				x += @len
				ctx.moveTo x, 0


		ctx.strokeStyle = "#ffffff";
		ctx.stroke()
		ctx.closePath()

	set_todo:(@todo)->

	change_len:(percent)->

		@len *= percent
