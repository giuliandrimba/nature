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

	changed:false

	constructor:(@_radius, @_color, @x, @y)->
		@mass = @_radius

		@_x = @x if @x
		@_y = @y if @y

		Object.defineProperties @,
			"radius":
				get:()->
					@_radius
				set:(value)->
					@_radius = value
					@changed = true

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
					@changed = true

	forward:()->
		@x = @_x + @x_vel
		@y = @_y + @y_vel
		@bounds()
		@_x = @x
		@_y = @y
		@changed = true


	draw:->
		unless @changed is false
			@context.fillStyle = @color
			@context.beginPath()
			@context.arc @_x, @_y, @radius, 0, Math.PI*2, true
			@context.closePath()
			@context.fill()
			@changed = false

	bounds:()->
		@x_vel *= -1 if (@x >= (@canvas.width - @radius) || @x < (0 + @radius))
		@y_vel *= -1 if (@y >= (@canvas.height - @radius) || @y < (0 + @radius))