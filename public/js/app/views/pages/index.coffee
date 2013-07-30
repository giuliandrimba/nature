###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		AppView = require 'app/views/app_view'
		Style = require 'styles/pages/index'
		Menu = require 'app/views/pages/menu'
		
		module.exports = class Index extends AppView
		
			title: "Codeman _Labs"
		
			after_render:()->
				@setup()
		
			setup:()->
				@menu = new Menu ".footer"
				@logo = @el.find ".logo-labs"
		
			before_in:()->
				@logo.css {opacity:0}
		
			in:()->
				super
				TweenLite.to @logo, 0, {css:{opacity:1}, delay:0.1}
				@logo.spritefy "logo-labs",
					duration:1
					count:1
					onComplete:()=>
						@menu.in()
		
				@logo.animation.play()
						
		
			constructor:()->
		