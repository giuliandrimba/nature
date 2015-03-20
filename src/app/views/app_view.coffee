View = require 'theoricus/mvc/view'
require 'app/config/vendors'

module.exports = class AppView extends View

  set_triggers: ->
    super()

    window.navigate = @navigate

    # automagically route links starting with "/"
    @el.find( 'a.bt-menu[href*="/"]' ).each ( index, item ) =>
      $( item ).click ( event ) =>
        @navigate $( event.delegateTarget ).attr 'href'
        return off
