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
		@scene = new Scene "canvas", "#000"

		@scene.on "tick", @on_tick

		@red = new Circle 40, "#ff0000", 50, 50
		@red.speed = 10
		@red.angle = 30
		@scene.add @red

	on_tick:()=>
		@red.forward()

	add_target:(e)=>
		@mouse_x = e.pageX
		@mouse_y = e.pageY

		@target = new Circle 10, "#ff0000", @mouse_x, @mouse_y
		@scene.add @target


	on_resize:()->
		@canvas.attr "width", @window.width()
		@canvas.attr "height", @window.height()


