MicroEvent = require '../utils/microevent'
Calc = require '../utils/calc'

module.exports = class Circle extends MicroEvent

	_angle:10
	_radians:0
	speed:5

	path:[]
	counter:0
	next_x:0
	next_y:0

	_radius:0
	_color:"#000"

	vx:0
	vy:0

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
					@vx = Math.cos(@_radians) * @speed
					@vy = Math.sin(@_radians) * @speed
					@changed = true

	draw:->
		unless @changed is false

			unless @hit
				@_x = @next_x
				@_y = @next_y

			@context.fillStyle = @color
			@context.beginPath()
			@context.arc @_x, @_y, @radius, 0, Math.PI*2, true
			@context.closePath()
			@context.fill()
			@changed = false
