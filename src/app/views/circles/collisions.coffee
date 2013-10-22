AppView = require 'app/views/app_view'
Scene = require 'board/scene'
Ball = require 'board/physic/ball'
Path = require 'board/geometry/path'

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

		i = 0
		while i < 10
			ball = new Ball 3 + (Math.random() * 9), "#fff"
			ball.speed = 4
			ball.angle = Math.floor(Math.random() * 360)
			ball.hit = true
			@scene.add ball
			i++


	on_tick:()=>
		ball.move() for ball in @scene.elements

	add_target:(e)=>
		@mouse_x = e.pageX
		@mouse_y = e.pageY

		@target = new Ball  3 + (Math.random() * 9), "#ffffff", @mouse_x, @mouse_y
		@target.speed = 4
		@target.angle = Math.floor(Math.random() * 360)
		@scene.add @target


	on_resize:()->
		@canvas.attr "width", @window.width()
		@canvas.attr "height", @window.height()


