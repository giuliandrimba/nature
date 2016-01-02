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
    setTimeout ()=>
      @el.addClass "in"
    ,
      0

    cb?()

  events:()->
    History.Adapter.bind window, 'statechange', =>
      @update()

  update:=>
