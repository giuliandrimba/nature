MicroEvent = require 'app/libs/board/utils/microevent'
Calc = require 'app/libs/board/utils/calc'

module.exports = class Scene extends MicroEvent

	context:null
	canvas:null
	elements:[]
	background_color:null

	constructor:(canvas_id, @background_color)->
		@stats = new Stats
		@stats.setMode 0
		@stats.domElement.style.position = 'absolute';
		@stats.domElement.style.left = '0px';
		@stats.domElement.style.top = '0px';

		document.body.appendChild @stats.domElement
		setInterval (=>
		  @stats.begin()
		  @stats.end()
		), 1000 / 60


		@canvas = document.getElementById canvas_id
		@context = @canvas.getContext "2d"
		@ticker = window.requestAnimationFrame @tick

	tick:=>
		@emit "tick"
		@update()
		window.requestAnimationFrame @tick

	update:()=>
		@emit "update"
		@context.fillStyle = @background_color
		@context.fillRect 0, 0, @canvas.width, @canvas.height

		for element in @elements
			element.draw()

		@collisions()


	add:(element)->
		@elements.push @at(element)
		element.context = @context
		element.canvas = @canvas
		element.scene = @

	destroy:(element)=>
		for item,i in @elements
			@elements.slice(i,0) if item is element

	at:(element)->
		return element if (element.x or element.y)


		element._x = element.radius + (Math.random() * (window.innerWidth - element.radius))
		element._y = element.radius + (Math.random() * (window.innerHeight - element.radius))
		pos_ok = false


		while pos_ok is false

			if @elements.length is 0
				pos_ok = true
				return element

			for ball in @elements
				unless @hit_circle(element, ball)
					pos_ok = true

		element

	hit_circle:(ball1, ball2)->
		retval = false
		dx = ball1.x - ball2.x
		dy = ball1.y - ball2.y
		distance = (dx * dx + dy * dy)
		retval = true  if distance <= (ball1.radius + ball2.radius) * (ball1.radius + ball2.radius)
		return retval

	collisions:()->
		for circle,i in @elements
			for test_circle, j in @elements
				if circle.hit and test_circle.hit and circle isnt test_circle
					if @hit_circle(circle, test_circle)
						@collide circle, test_circle

	collide:(el0, el1)->
		dx = el0.x - el1.x
		dy = el0.y - el1.y
		collisionAngle = Math.atan2(dy, dx)
		speed1 = Math.sqrt(el0.x_vel * el0.x_vel + el0.y_vel * el0.y_vel)
		speed2 = Math.sqrt(el1.x_vel * el1.x_vel + el1.y_vel * el1.y_vel)
		direction1 = Math.atan2(el0.y_vel, el0.x_vel)
		direction2 = Math.atan2(el1.y_vel, el1.x_vel)
		x_vel_1 = speed1 * Math.cos(direction1 - collisionAngle)
		y_vel_1 = speed1 * Math.sin(direction1 - collisionAngle)
		x_vel_2 = speed2 * Math.cos(direction2 - collisionAngle)
		y_vel_2 = speed2 * Math.sin(direction2 - collisionAngle)
		final_x_vel_1 = ((el0.mass - el1.mass) * x_vel_1 + (el1.mass + el1.mass) * x_vel_2) / (el0.mass + el1.mass)
		final_x_vel_2 = ((el0.mass + el0.mass) * x_vel_1 + (el1.mass - el0.mass) * x_vel_2) / (el0.mass + el1.mass)
		final_y_vel_1 = y_vel_1
		final_y_vel_2 = y_vel_2
		el0.x_vel = Math.cos(collisionAngle) * final_x_vel_1 + Math.cos(collisionAngle + Math.PI / 2) * final_y_vel_1
		el0.y_vel = Math.sin(collisionAngle) * final_x_vel_1 + Math.sin(collisionAngle + Math.PI / 2) * final_y_vel_1
		el1.x_vel = Math.cos(collisionAngle) * final_x_vel_2 + Math.cos(collisionAngle + Math.PI / 2) * final_y_vel_2
		el1.y_vel = Math.sin(collisionAngle) * final_x_vel_2 + Math.sin(collisionAngle + Math.PI / 2) * final_y_vel_2

		el0.x = (el1.x += el1.x_vel);
		el0.y = (el1.y += el1.y_vel);
		el0.x = (el1.x += el1.x_vel);
		el0.y = (el1.y += el1.y_vel);





