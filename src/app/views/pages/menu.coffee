Template = require 'templates/pages/menu'
Routes = require 'app/config/routes'

module.exports = class Menu

  constructor:(at)->
    @el = $(Template())
    $(at).append @el
    @setup()

  visible:=>
    @el.css("display","block")

  on_resize:()=>

  active_page:->

    page = window.location.href.toString().split("/").pop()

    unless page.length

      page = Routes.root.substring(1)

    return page

  setup:()->
    @window = $(window)
    @wrapper = $ ".wrapper"
    @on_resize()
    @events()

  in:(cb)->
    unless @active_page() is "info"
      @show()
    cb?()

  hide:=>
    @el.removeClass "in"

  show:=>
    setTimeout ()=>
      @el.addClass "in"
    ,
      0

  events:()->
    History.Adapter.bind window, 'statechange', =>
      if @active_page() is "info"
        @hide()
      else
        @show()

  update:=>
