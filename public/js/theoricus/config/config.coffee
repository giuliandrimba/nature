###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  module.exports = class Config
  
    animate_at_startup: false
    enable_auto_transitions: true
  
    app_name: null
    no_push_state: null
    disable_transitions: null
  
    ###
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
    ###
    constructor:( @the, @Settings )->
      @app_name = "app"
  
      @disable_transitions = @Settings.disable_transitions ? false
      @animate_at_startup = @Settings.animate_at_startup ? true
      @enable_auto_transitions = @Settings.enable_auto_transitions ? true
      @autobind = @Settings.autobind ? false
      @vendors = @Settings.vendors