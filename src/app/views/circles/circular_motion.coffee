AppView = require 'app/views/app_view'
Scene = require 'board/scene'
Circle = require 'board/geometry/circle'
Path = require 'board/geometry/path'

module.exports = class CircularMotion extends AppView

	path_radius:30

	after_render:()->
		@window = $ window

		@canvas = $ "#canvas"
		@scene = new Scene "canvas", "#000000"
		@ball = new Circle 10, "#ffffff"
		@ball.angle = 0


		@scene.on "tick", @on_tick
		@scene.add @ball

		new Path @ball

	on_tick:()=>
		@ball.x = @center_x + Math.cos(@ball.angle) * @path_radius
		@ball.y = @center_y + Math.sin(@ball.angle) * @path_radius
		@path_radius += 0.1
		@ball.angle += 0.1

	on_resize:()->
		@center_x = @window.width() / 2
		@center_y = @window.height() / 2
		@canvas.attr "width", @window.width()
		@canvas.attr "height", @window.height()
