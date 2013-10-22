AppView = require 'app/views/app_view'
Menu = require 'app/views/pages/menu'

module.exports = class Index extends AppView

	title: "Codeman _Labs"

	after_render:()->
		@setup()

	setup:()->
		@wrapper = $(@el).find ".wrapper"
		@window = $ window
		@menu = new Menu ".footer"
		@logo = @el.find ".logo-labs"

	before_in:()->
		@logo.css {opacity:0}

	on_resize:()=>
		@wrapper.css
			width: @window.width()
			height: @window.height()

		@menu.on_resize()


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
