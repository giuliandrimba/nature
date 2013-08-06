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
					top: @window.height() - @el.height()
		
				@menu.css
		
					left: @wrapper.width() / 2 - @menu.width() / 2
		
			setup:()->
				@window = $(window)
				@wrapper = $ ".wrapper"
				@arrow = @el.find ".arrow"
				@menu = @el.find ".nav"
		
				@on_resize()
				@events()
		
				@arrow.css 
					top:100
		
			in:()->
				TweenLite.to @arrow, 0.5, {css:{top:10}, ease:Back.easeOut}
		
			events:()->
				@window.bind "resize", @on_resize
				@el.bind "mouseenter", @show
				@el.bind "mouseleave", @hide
				@menu.find("a").bind "mouseenter", @over
				@menu.find("a").bind "mouseleave", @out
		
			over:(e)=>
				bt = $(e.currentTarget)
		
				return if bt.hasClass "active"
				TweenLite.to bt.find(".white_dot"), 0.15, {css:{width:1, height:1, marginLeft:-1, marginTop:-1}}
				TweenLite.to bt.find(".dot"), 0.15, {css:{opacity:0}}
		
			out:(e)=>
				bt = $(e.currentTarget)
				return if bt.hasClass "active"
				TweenLite.to bt.find(".white_dot"), 0.15, {css:{width:25, height:25, marginLeft:-(26 / 2), marginTop:-(26/2)}}
				TweenLite.to bt.find(".dot"), 0.15, {css:{opacity:1}}
		
			hide:()=>
				TweenLite.to @arrow, 0.5, {css:{top:20}, ease:Expo.easeOut, delay:0.4}
		
				amount = @menu.find("li").length
				total_delay = amount / 2
				delay = 0
				distance = 0
				@delay_v = 0
		
				for li, i in @menu.find "li a"
					distance = total_delay - Math.abs(total_delay - @delay_v)
					@delay_v += 1
					delay = distance / 500
					li = $(li)
					TweenLite.to li, 0.4, {css:{top:150}, ease:Back.easeIn, delay:i * delay}
		
			show:()=>
		
				TweenLite.to @arrow, 0.5, {css:{top:150}, ease:Expo.easeOut}
		
				amount = @menu.find("li").length
				total_delay = amount / 2
				delay = 0
				distance = 0
				@delay_v = 0
		
				for li, i in @menu.find "li a"
					distance = total_delay - Math.abs(total_delay - @delay_v)
					@delay_v += 1
					delay = distance / 500
					li = $(li)
					TweenLite.to li, 0.4, {css:{top:20}, ease:Back.easeOut, delay:i * delay}
		