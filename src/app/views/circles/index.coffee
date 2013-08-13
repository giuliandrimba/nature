AppView = require 'app/views/app_view'
Style = require 'styles/circles/index'
Scene = require 'app/libs/board/scene'
Circle = require 'app/libs/board/basic/circle'

module.exports = class Index extends AppView

	events:
		"#canvas click":"add_target"

	mouse_x:0
	mouse_y:0

	after_render:()->
		@window = $ window

		@canvas = $ "#canvas"
		@scene = new Scene "canvas", "#ff0000"

		@scene.on "tick", @on_tick

		for i in [1,2,3,4,5,6,7,8,9,0]
			ball = new Circle 10, "#fff"
			ball.speed = 4
			ball.angle = Math.floor(Math.random() * 360)
			ball.hit = true
			@scene.add ball



	on_tick:()=>
		ball.forward() for ball in @scene.elements

	add_target:(e)=>
		@mouse_x = e.pageX
		@mouse_y = e.pageY

		@target = new Circle 10, "#ff0000", @mouse_x, @mouse_y
		@scene.add @target


	on_resize:()->
		@canvas.attr "width", @window.width()
		@canvas.attr "height", @window.height()


