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
    @anim_description = new AnimText @el.find(".description"), 500
    @anim_description.start()
    @anim_title = new AnimText @el.find(".title")
    @el.css "opacity": 0
    @el.animate {opacity: 1}, 1000
    @anim_title.start()

