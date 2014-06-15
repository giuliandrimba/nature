Template = require 'templates/pages/menu'
Routes = require 'app/config/routes'

module.exports = class Menu

	labs:[]
	constructor:(at)->
		for route of Routes.routes
			@labs.push(url:route.toString(), name:route.toString().substring(1)) if Routes.routes[route].lab
		@el = $(Template({labs:@labs}))
		$(at).append @el
		@setup()

	on_resize:()=>
		@el.css
			top: @window.height() - @el.height()
			width: @window.width()

		@menu.css

			left: @wrapper.width() / 2 - @menu.width() / 2

	check_active:->

		bts = $("ul.nav a")

		for bt in bts
			$(bt).removeClass "active"
			@out_btn $(bt)

		active_btn = $("##{@active_page()}")

		active_btn.addClass "active"
		@over_btn active_btn

	active_page:->

		page = window.location.href.toString().split("/").pop()

		unless page.length

			page = Routes.root.substring(1)

		return page

	setup:()->
		@window = $(window)
		@wrapper = $ ".wrapper"
		@arrow = @el.find ".arrow"
		@menu = @el.find ".nav"

		@on_resize()
		@events()
		@check_active()

		@arrow.css
			top:100

	in:(cb)->
		TweenLite.to @arrow, 0.5, {css:{top:10}, ease:Back.easeOut, onComplete:cb}

	events:()->
		@window.bind "resize", @on_resize
		@el.bind "mouseenter", @show
		@el.bind "mouseleave", @hide
		@menu.find("a").bind "mouseenter", @over
		@menu.find("a").bind "mouseleave", @out

		History.Adapter.bind window, 'statechange', =>
			@check_active()

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

	out_btn:(bt)->
		TweenLite.set bt.find(".white_dot"), {css:{width:25, height:25, marginLeft:-(26 / 2), marginTop:-(26/2)}}
		TweenLite.set bt.find(".dot"), {css:{opacity:1}}

	over_btn:(bt)->
		TweenLite.set bt.find(".white_dot"), {css:{width:1, height:1, marginLeft:-1, marginTop:-1}}
		TweenLite.set bt.find(".dot"), {css:{opacity:0}}

	hide:()=>

		TweenLite.to @arrow, 0.5, {css:{top:10}, ease:Expo.easeOut, delay:0.4}

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
			TweenLite.to li, 0.4, {css:{top:250}, ease:Back.easeIn, delay:i * delay}

	show:()=>

		TweenLite.killTweensOf @arrow
		TweenLite.to @arrow, 0.5, {css:{top:250}, ease:Expo.easeOut}

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
			TweenLite.to li, 0.4, {css:{top:50}, ease:Back.easeOut, delay:i * delay}
