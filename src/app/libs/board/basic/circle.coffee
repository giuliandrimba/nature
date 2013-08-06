MicroEvent = require 'app/libs/board/utils/microevent'

module.exports = class Circle extends MicroEvent

	angle:10
	speed:5

	path:[]
	counter:0
	mass:0
	next_x:0
	next_y:0

	_radius:0
	color:"#000"

	_x:0
	_y:0

	constructor:(@_radius, @_color, @_x = 0, @_y = 0)->
		@mass = @radius

		Object.defineProperties @,
			"x":
				get:()->
					@_x
				set:(value)->
					@_x = value
					@scene.update()
			"y":
				get:()->
					@_y
				set:(value)->
					@_y = value
					@scene.update()
			"radius":
				get:()->
					@_radius
				set:(value)->
					@_radius = value
					@scene.update()

			"color":
				get:()->
					@_color
				set:(value)->
					@_color = value
					@scene.update()


	draw:->
		@context.fillStyle = @_color
		@context.beginPath()
		@context.arc @_x, @_y, @_radius, 0, Math.PI*2, true
		@context.closePath()
		@context.fill()

	update:()=>
	    radians = @angle * Math.PI / 180
	    @vx = Math.cos(radians) * @speed
	    @vy = Math.sin(radians) * @speed
	    @next_x = @x + @vx
	    @next_y = @y + @vy
	    @boundaries()

	move:()->
	    @x = @next_x
	    @y = @next_y

	destroy:()->
		console.log @scene

  	boundaries:()->
    	@angle = 180 - @angle if (@next_x >= (@canvas.width - @radius) || @next_x < (0 + @radius))
    	@angle = 360 - @angle if (@next_y >= (@canvas.height - @radius) || @next_y < (0 + @radius))