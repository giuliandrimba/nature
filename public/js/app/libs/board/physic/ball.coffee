###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		Circle = require 'app/libs/board/geometry/circle'
		
		module.exports = class Ball extends Circle
		
			hit:true
			mass:0
		
			move:()->
				@vx = @vx - (@vx * @scene.friction)
				@vy = @vy - (@vy * @scene.friction)
				@next_x = @_x + @vx
				@next_y = @_y + @vy
				@bounds()
				@_x = @next_x
				@_y = @next_y
				@changed = true
			
			bounds:()->
				@vx *= -1 if (@next_x >= (@canvas.width - @radius) || @next_x < (0 + @radius))
				@vy *= -1 if (@next_y >= (@canvas.height - @radius) || @next_y < (0 + @radius))