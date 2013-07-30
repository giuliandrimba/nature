###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  View = require 'theoricus/mvc/view'
  Vendors = require 'app/config/vendors'
  
  exports.module = class AppView extends View
  
    set_triggers: ->
      super()
  
      # automagically route links starting with "/"
      @el.find( 'a[href*="/"]' ).each ( index, item ) =>
        $( item ).click ( event ) =>
          @navigate $( event.delegateTarget ).attr 'href'
          return off
  