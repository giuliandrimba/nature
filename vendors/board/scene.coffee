MicroEvent = require './utils/microevent'
Calc = require './utils/calc'

console.log MicroEvent

module.exports = class Scene extends MicroEvent

	context:null
	canvas:null
	elements:[]
	background_color:null
	friction:0

	constructor:(canvas_id, @background_color)->

		@canvas = document.getElementById canvas_id
		@context = @canvas.getContext "2d"
		@ticker = window.requestAnimationFrame @tick

	tick:=>
		@emit "tick"
		@update()
		window.requestAnimationFrame @tick

	update:()=>
		@context.fillStyle = @background_color
		@context.fillRect 0, 0, @canvas.width, @canvas.height

		@collisions()

		for element in @elements
			element.draw()

		@emit "update"


	add:(element)->
		@elements.push @at(element)
		element.context = @context
		element.canvas = @canvas
		element.scene = @
		element.changed = true

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
		retval = true  if distance <= ((ball1.radius + ball2.radius) * (ball1.radius + ball2.radius))
		return retval

	collisions:()->
		for circle,i in @elements
			return if circle.hit is false
			for test_circle, j in @elements
				if circle.hit and test_circle.hit and circle isnt test_circle
					if @hit_circle(circle, test_circle)
						@collide circle, test_circle

	collide:(el0, el1)->
		dx = el0.x - el1.x
		dy = el0.y - el1.y
		collisionAngle = Math.atan2(dy, dx)
		speed1 = Math.sqrt(el0.vx * el0.vx + el0.vy * el0.vy)
		speed2 = Math.sqrt(el1.vx * el1.vx + el1.vy * el1.vy)
		direction1 = Math.atan2(el0.vy, el0.vx)
		direction2 = Math.atan2(el1.vy, el1.vx)
		vx_1 = speed1 * Math.cos(direction1 - collisionAngle)
		vy_1 = speed1 * Math.sin(direction1 - collisionAngle)
		vx_2 = speed2 * Math.cos(direction2 - collisionAngle)
		vy_2 = speed2 * Math.sin(direction2 - collisionAngle)
		final_vx_1 = ((el0.mass - el1.mass) * vx_1 + (el1.mass + el1.mass) * vx_2) / (el0.mass + el1.mass)
		final_vx_2 = ((el0.mass + el0.mass) * vx_1 + (el1.mass - el0.mass) * vx_2) / (el0.mass + el1.mass)
		final_vy_1 = vy_1
		final_vy_2 = vy_2
		el0.vx = Math.cos(collisionAngle) * final_vx_1 + Math.cos(collisionAngle + Math.PI / 2) * final_vy_1
		el0.vy = Math.sin(collisionAngle) * final_vx_1 + Math.sin(collisionAngle + Math.PI / 2) * final_vy_1
		el1.vx = Math.cos(collisionAngle) * final_vx_2 + Math.cos(collisionAngle + Math.PI / 2) * final_vy_2
		el1.vy = Math.sin(collisionAngle) * final_vx_2 + Math.sin(collisionAngle + Math.PI / 2) * final_vy_2

		el0.x = (el0.x += el0.vx);
		el0.y = (el0.y += el0.vy);
		el0.x = (el1.x += el1.vx);
		el0.y = (el1.y += el1.vy);





