###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
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
		
			add:(element)->
				@elements.push @at(element)
				element.context = @context
				element.canvas = @canvas
				element.scene = @
		
			destroy:(element)=>
				for item,i in @elements
					@elements.slice(i,0) if item is element
		
			at:(element)->
				return element if (element.x or element.y or !@elements.length)
		
				element.x = Math.random() * @canvas.width
				element.y = Math.random() * @canvas.height
				pos_ok = false
		
				while pos_ok is false
					for ball in @elements
						unless @hit_circle(element, ball)
							pos_ok = true
		
				element
		
			hit_circle:(el0, el1)->
				dx = el1.x - el0.x
				dy = el1.y - el0.y
				dist = dx * dx + dy * dy
		
				return true if dist <= (el0.radius + el1.radius) * (el0.radius + el1.radius)
				return false
		
		
		