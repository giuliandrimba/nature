View = require 'theoricus/mvc/view'

exports.module = class AppView extends View

  set_triggers: ->
    super()

    # automagically route links starting with "/"
    @el.find( 'a[href*="/"]' ).each ( index, item ) =>
      $( item ).click ( event ) =>
        @navigate $( event.delegateTarget ).attr 'href'
        return off
