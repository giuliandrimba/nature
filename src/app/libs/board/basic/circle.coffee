MicroEvent = require 'app/libs/board/utils/microevent'
Calc = require 'app/libs/board/utils/calc'

module.exports = class Circle extends MicroEvent

	_angle:10
	_radians:0
	hit:false
	speed:5

	path:[]
	counter:0
	mass:0
	next_x:0
	next_y:0

	_radius:0
	_color:"#000"

	x_vel:0
	y_vel:0

	_x:0
	_y:0

	constructor:(@_radius, @_color, @_x, @_y)->
		@mass = @radius

		Object.defineProperties @,
			"x":
				get:()->
					@_x
				set:(value)->
					@_x = value
			"y":
				get:()->
					@_y
				set:(value)->
					@_y = value
			"radius":
				get:()->
					@_radius
				set:(value)->
					@_radius = value
					@bounds()

			"color":
				get:()->
					@_color
				set:(value)->
					@_color = value
			"angle":
				get:()->
					@_angle
				set:(value)->
					@_angle = value
					@_radians = Calc.ang2rad @_angle
					@x_vel = Math.cos(@_radians) * @speed
					@y_vel = Math.sin(@_radians) * @speed

	forward:()->
		@x += @x_vel
		@y += @y_vel
		@bounds()


	draw:->

		@context.fillStyle = @color
		@context.beginPath()
		@context.arc @x, @y, @radius, 0, Math.PI*2, true
		@context.closePath()
		@context.fill()

	bounds:()->
		@angle = 180 - @angle if (@x >= (@canvas.width - @radius) || @x < (0 + @radius))
		@angle = 360 - @angle if (@y >= (@canvas.height - @radius) || @y < (0 + @radius))