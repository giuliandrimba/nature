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
				@canvas = document.getElementById canvas_id
				@context = @canvas.getContext "2d"
				@ticker = window.requestAnimationFrame @tick
				@update()
		
			tick:=>
				@emit "tick"
				window.requestAnimationFrame @tick
		
			update:()=>
				@emit "update"
				@context.fillStyle = @background_color
				@context.fillRect 0, 0, @canvas.width, @canvas.height
		
				element.draw() for element in @elements
		
			add:(element)->
				@elements.push element
				element.context = @context
				element.canvas = @canvas
				element.scene = @
				element.draw()
		
			destroy:(element)=>
				for item,i in @elements
					@elements.slice(i,0) if item is element
		
		