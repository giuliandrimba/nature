AppView = require 'app/views/app_view'
Menu = require 'app/views/pages/menu'
Routes = require "app/config/routes"

module.exports = class Index extends AppView

  animating_current_view: false
  after_render:()->
    @setup()
    @set_triggers()

  setup:()->
    @windowH = $(window).height()
    @wrapper = $(@el).find ".wrapper"
    @window = $ window
    @border = $(".border")
    @menu = new Menu ".footer"
    @logo = @el.find ".logo-labs"
    @hideDescriptionTimeout = undefined
    @events()

  before_in:()->
    @logo.css {opacity:0}

  on_resize:()=>

    @border.width @window.width() - 10
    @border.height @window.height() - 10

    @wrapper.css
      width: @window.width()
      height: @window.height()

    @menu.on_resize()


  in:(done)->
    @before_in()

    if !@in_iframe()
      @menu.visible()

    @menu.in ()=>
      @after_in?()

  events:=>

    $(document.body).bind "mousemove", @onMouseMove
    $(window).bind "resize", @onResize
    @showDescription()

    @el.find(".bt-prev").bind "click", (e)=>
      e.preventDefault()
      return if @animating_current_view
      @animating_current_view = true
      route = Routes.get_prev "/"+Routes.active_page()
      @navigate route
      setTimeout ()=>
        @animating_current_view = false
      ,
        1500

    @el.find(".bt-next").bind "click", (e)=>
      e.preventDefault()
      return if @animating_current_view
      @animating_current_view = true
      route = Routes.get_next "/"+Routes.active_page()
      @navigate route
      setTimeout ()=>
        @animating_current_view = false
      ,
        1500

  onMouseMove:(e)=>
    if e.screenY > @windowH - 100
      @showDescription()

  showDescription:=>

    TweenMax.killTweensOf $(".title")
    TweenMax.killTweensOf $(".description")

    TweenMax.to $(".title"), .5, opacity: 1
    TweenMax.to $(".description"), .5, opacity: 1

    window.clearTimeout @hideDescriptionTimeout
    @hideDescriptionTimeout = window.setTimeout @hideDescription, 4000

  hideDescription:=>

    TweenMax.killTweensOf $(".title")
    TweenMax.killTweensOf $(".description")

    TweenMax.to $(".title"), .5, opacity:0
    TweenMax.to $(".description"), .5, opacity:0

    @descHidden = true

  onResize:=>
    @windowH = $(window).height()

  goto:(e)->
    e.preventDefault()
    route = $(e.currentTarget).attr "href"
    @navigate route

  in_iframe: ->
    try
      return window.self != window.top
    catch e
      return true
    return
