###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		Template = require 'templates/pages/menu'
		Style = require 'styles/pages/menu'
		
		module.exports = class Menu
		
			constructor:(at)->
				@el = $(Template())
				$(at).append @el
				@setup()
		
			on_resize:()=>
				@el.css
					top: @window.height() - @el.height() - 25
		
				@menu.css
		
					left: @wrapper.width() / 2 - @menu.width() / 2
		
			setup:()->
				@window = $(window)
				@wrapper = $ ".wrapper"
				@arrow = @el.find ".arrow"
				@menu = @el.find ".nav"
		
				@on_resize()
				@events()
		
			events:()->
				@window.bind "resize", @on_resize
				@el.bind "mouseenter", @show
				@el.bind "mouseleave", @hide
		
			hide:()=>
				delay = 0.07
				last_delay = 0.4
				for li, i in @menu.find "li a"
					li = $(li)
					TweenLite.to li, 0.4, {css:{top:100}, ease:Back.easeIn, delay:i * delay}
					delay -= 0.005
		
				TweenLite.to @arrow, 0.5, {css:{top:10}, ease:Back.easeOut, delay:last_delay}
		
			show:()=>
				TweenLite.to @arrow, 0.5, {css:{top:60}, ease:Expo.easeOut}
		
				delay = 0.07
				for li, i in @menu.find "li a"
					li = $(li)
					TweenLite.to li, 0.4, {css:{top:10}, ease:Back.easeOut, delay:i * delay}
					delay -= 0.005