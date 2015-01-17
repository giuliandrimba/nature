AppView = require 'app/views/app_view'
Menu = require 'app/views/pages/menu'

module.exports = class Index extends AppView

  after_render:()->
    @setup()
    @set_triggers()

  setup:()->
    @wrapper = $(@el).find ".wrapper"
    @window = $ window
    @border = $(".border")
    @menu = new Menu ".footer"
    @logo = @el.find ".logo-labs"

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
    TweenLite.to @logo, 0, {css:{opacity:1}, delay:0.1}
    @logo.spritefy "logo-labs",
      duration:1
      count:1
      onComplete:()=>
        @menu.in ()=>
          @after_in?()

    @logo.animation.play()

  goto:(e)->
    e.preventDefault()
    route = $(e.currentTarget).attr "href"
    # @navigate route
