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

	constructor:(@_radius, @_color, @next_x, @next_y)->
		@mass = @_radius

		@_x = @next_x if @next_x
		@_y = @next_y if @next_y

		Object.defineProperties @,
			"x":
				get:()->
					@next_x
				set:(value)->
					@next_x = value
					@changed = true
			"y":
				get:()->
					@next_y
				set:(value)->
					@next_y = value
					@changed = true
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
		@x_vel = @x_vel - (@x_vel * @scene.friction)
		@y_vel = @y_vel - (@y_vel * @scene.friction)
		@next_x = @_x + @x_vel
		@next_y = @_y + @y_vel
		@bounds()
		@_x = @next_x
		@_y = @next_y
		@changed = true


	draw:->
		# unless @changed is false
		@context.fillStyle = @color
		@context.beginPath()
		@context.arc @_x, @_y, @radius, 0, Math.PI*2, true
		@context.closePath()
		@context.fill()
		@changed = false

	bounds:()->
		@x_vel *= -1 if (@next_x >= (@canvas.width - @radius) || @next_x < (0 + @radius))
		@y_vel *= -1 if (@next_y >= (@canvas.height - @radius) || @next_y < (0 + @radius))