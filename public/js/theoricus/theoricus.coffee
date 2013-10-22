###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    Theoricus module
    @module theoricus
  ###
  
  Config = require 'theoricus/config/config'
  Factory = require 'theoricus/core/factory'
  Processes = require 'theoricus/core/processes'
  
  require 'inflection'
  require 'jquery'
  require 'json'
  
  
  ###*
    Theoricus main class.
    @class Theoricus
  ###
  module.exports = class Theoricus
  
    ###*
      Base path for your application, in case it runs in a subfolder. If not, this
      can be left blank, meaning your application will run in the `web_root` dir
      on your server.
  
      @property {String} base_path
    ###
    base_path: ''
  
    ###*
      Instance of Factory class.
      @property {Factory} factory
    ###
    factory  : null
  
    ###*
      Instance of {{#crossLink "Config"}}{{/crossLink}} class, fed by the Settings class.
      @property {Config} config
    ###
    config   : null
  
    ###*
      Instance of Processes class.
      @property {Processes} processes
    ###
    processes: null
  
    ###*
      Reference to `window.crawler` object, this object contains a property called `is_rendered` which is set to true whenever the current process finishes rendering.
  
      This object is used specially for server-side indexing of Theoricus's apps, though the use of <a href="http://github.com/serpentem/snapshooter">Snapshooter</a>.
      @property {Crawler} crawler
    ###
    crawler: (window.crawler = is_rendered: false)
  
    ###*
      Theoricus constructor, must to be invoked by the application with a `super`
      call.
      @class Theoricus
      @constructor
      @param Settings {Object} App Settings
      @param Routes {Object} App Routes
    ###
    constructor:( @Settings, @Routes )->
      @config  = new Config @, @Settings
      @factory = new Factory @
  
    ###*
      Starts the Theoricus engine, plugging the Processes onto the Router system.
      @method start
    ###
    start: ->
      @processes = new Processes @, @Routes