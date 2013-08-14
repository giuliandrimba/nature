###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		AppView = require 'app/views/app_view'
		Style = require 'styles/circles/circular_motion'
		Scene = require 'app/libs/board/scene'
		Circle = require 'app/libs/board/basic/circle'
		
		module.exports = class CircularMotion extends AppView
		
			after_render:()->
				@window = $ window
		
				@canvas = $ "#canvas"
				@scene = new Scene "canvas", "#000000"
				@ball = new Circle 30, "#ffffff"
				@ball.angle = 0
		
				@scene.on "tick", @on_tick
				@scene.add @ball
		
			on_tick:()=>
				@ball.x = @center_x + Math.cos(@ball.angle) * @ball.radius
				@ball.y = @center_y + Math.sin(@ball.angle) * @ball.radius
				@ball.angle++
		
			on_resize:()->
				@center_x = @window.width() / 2
				@center_y = @window.height() / 2
				@canvas.attr "width", @window.width()
				@canvas.attr "height", @window.height()
		