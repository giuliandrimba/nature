AppView = require 'app/views/app_view'
Routes = require "app/config/routes"

module.exports = class Index extends AppView

  destroy:->
    super

  after_render:=>
    setTimeout ()=>
      @el.find(".info").addClass "animate-in"
    ,
      0

    @events()

  events:=>
    @el.find("li a").bind "click", (e)=>
      e.preventDefault()
      id = parseInt(e.currentTarget.id)
      @navigate Routes.get_route_id id

    @el.find(".bt-close").bind "click", (e)=>
      e.preventDefault()
      @navigate window.prevPage
