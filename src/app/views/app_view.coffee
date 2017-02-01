View = require 'theoricus/mvc/view'
require 'app/config/vendors'
AnimText = require "app/lib/anim_letter/text"

module.exports = class AppView extends View

  set_triggers: ->
    super()

    window.navigate = (url)=> @navigate(url)

    # automagically route links starting with "/"
    @el.find( 'a.bt-menu[href*="/"]' ).each ( index, item ) =>
      $( item ).click ( event ) =>
        @navigate $( event.delegateTarget ).attr 'href'
        return off

  in:->
    super()
    return if @el.find(".title").length is 0
    @anim_title = new AnimText @el.find(".title"), 500
    @animate_description()
    @el.css "opacity": 0
    @el.animate {opacity: 1}, 1000
    @anim_title.start()

    if !@in_iframe()
      delay = 1500
    else
      delay = 0

    setTimeout ()=>
      @el.find("canvas").addClass("tween")
    ,
      delay

  animate_description:=>

    description = @el.find(".description")
    texts = description.html().split("<br>")
    description.empty()

    for t in texts
      span = $("<div></div>")
      span.text(t)
      description.append span
      anim = new AnimText span, 750
      anim.start()

  in_iframe: ->
    try
      return window.self != window.top
    catch e
      return true
    return



