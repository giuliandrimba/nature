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
	position: []
	new_points: []

	constructor:(@lsys, @len, @theta, @iterations)->

		@todo = {}
		@y = 0
		@points = []
		@position = []
		@new_points = []
		@run()

	start:(@lsys, @len, @theta, @iterations)=>
		@todo = {}
		@y = 0
		@position = []
		@run()

	run:->

		i = 0

		@lsys.reset()

		while i < @iterations

			@set_todo @lsys.generate(), (@len / 1.1)
			i++

		@get_position()
		@animate_points()

	animate_points:=>

		for p,i in @points
			pos = @position[i]
			TweenMax.to p, 2, x:pos.x, y:pos.y, ease: Bounce.easeOut
			# TweenMax.to p, 5, x:pos.x, y:pos.y

	get_position:=>

		@ang = 0
		@x = 0
		@y = 0

		for c, i in @todo.s

			if c is "F" or c is "G"

				rad = Calc.deg2rad @ang
				@x += (Math.cos(rad) * @todo.l)
				@y += (Math.sin(rad) * @todo.l)

				@position.push
					x:@x
					y:@y

				if i > @points.length

					# @points.push
					# 	x: -(Math.random() * 1000) + (Math.random() * 1000)
					# 	y: -(Math.random() * 1000) + (Math.random() * 1000)

					@points.push
						x: @x + (-(Math.random() * 1000) + (Math.random() * 1000))
						y: @y + (-(Math.random() * 1000) + (Math.random() * 1000))

			else if c is "+"
				@ang += @theta
			else if c is "-"
				@ang -= @theta

		while @points.length > @position.length
			@points.pop()

	update:->

	draw:(ctx)->

		ctx.beginPath()
		ctx.moveTo 0, 0

		for p,i in @points
			pos = @position[i]
			dist = Calc.dist p.x, p.y, pos.x, pos.y

			if dist < 10
				ctx.lineTo p.x, p.y

		ctx.strokeStyle = "#000";
		ctx.lineWidth = 2;
		ctx.stroke()
		ctx.closePath()

	set_todo:(todo, length)->
		@len = length
		@todo = s:todo, l:@len

