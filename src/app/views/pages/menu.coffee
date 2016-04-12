Template = require 'templates/pages/menu'
Routes = require 'app/config/routes'
View = require 'theoricus/mvc/view'

module.exports = class Menu extends View

  constructor:(at)->
    @el = $(Template())
    $(at).append @el
    window.currentPage = Routes.active_page()
    window.prevPage = Routes.active_page()
    @hideTimeout = undefined
    @setup()

  visible:=>
    @el.css("display","block")

  on_resize:()=>

  setup:()->
    @window = $(window)
    @windowH = @window.height()
    @wrapper = $ ".wrapper"
    @on_resize()
    @events()

  in:(cb)->
    unless Routes.active_page() is "info"
      @show()
    cb?()

  hide:=>
    @el.removeClass "in"

  show:=>
    setTimeout ()=>
      @el.addClass "in"
    ,
      0

    window.clearTimeout @hideTimeout
    @hideTimeout = setTimeout @hide, 4000

  events:()->

    $(document.body).bind "mousemove", @onMouseMove
    $(window).bind "resize", @onResize

    History.Adapter.bind window, 'statechange', =>
      window.prevPage = window.currentPage
      window.currentPage = Routes.active_page()
      @check_nav()
      if Routes.active_page() is "info"
        @hide()
      else
        @show()

    @check_nav()

  onResize:=>
    @windowH = @window.height()

  onMouseMove:(e)=>
    if Routes.active_page() is "info"
      return
    if e.screenY > @windowH - 100
      @show()

  check_nav:=>
    route = Routes.routes["/"+Routes.active_page()]

    if route.index >= 9
      @el.find(".bt-next").addClass "disabled"
    else
      @el.find(".bt-next").removeClass "disabled"

    if route.index is 0
      @el.find(".bt-prev").addClass "disabled"
    else
      @el.find(".bt-prev").removeClass "disabled"

  update:=>
