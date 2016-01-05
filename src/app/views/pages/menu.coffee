Template = require 'templates/pages/menu'
Routes = require 'app/config/routes'
View = require 'theoricus/mvc/view'

module.exports = class Menu extends View

  constructor:(at)->
    @el = $(Template())
    $(at).append @el
    window.currentPage = "/"
    window.prevPage = "/"
    @setup()

  visible:=>
    @el.css("display","block")

  on_resize:()=>

  setup:()->
    @window = $(window)
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

  events:()->

    History.Adapter.bind window, 'statechange', =>
      window.prevPage = window.currentPage
      window.currentPage = Routes.active_page()
      if Routes.active_page() is "info"
        @hide()
      else
        @show()

  update:=>
