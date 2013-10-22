###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    Config module
    @module config
  ###
  
  ###*
    Config class.
    @class Config
  ###
  module.exports = class Config
  
    ###*
      If true, execute all the animations at startup, or skip them and just render the views.
  
      @property {Boolean} animate_at_startup
    ###
    animate_at_startup: false
  
    ###*
      If true, insert automatically fadeIn/fadeOut transitions for the views.
  
      @property {Boolean} enable_auto_transitions
    ###
    enable_auto_transitions: true
  
    ###*
      If true, skip all the transitions, and just render the views.
  
      @property {Boolean} disable_transitions
    ###
    disable_transitions: null
  
    ###*
    Config constructor, initializing the app's config settings.
    @class Config
    @constructor
    @param the {Theoricus} Shortcut for app's instance
    @param Settings {Object} App settings
    ###
    constructor:( @the, @Settings )->
      @disable_transitions = @Settings.disable_transitions ? false
      @animate_at_startup = @Settings.animate_at_startup ? true
      @enable_auto_transitions = @Settings.enable_auto_transitions ? true
      @autobind = @Settings.autobind ? false
      @vendors = @Settings.vendors
  