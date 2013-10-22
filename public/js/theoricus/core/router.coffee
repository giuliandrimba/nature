###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ## Router & Route logic inspired by RouterJS:
  ## https://github.com/haithembelhaj/RouterJs
  
  ###*
    Core module
    @module core
  ###
  
  StringUril = require 'theoricus/utils/string_util'
  Route = require 'theoricus/core/route'
  
  require 'history'
  
  Factory = null
  
  ###*
    Proxies browser's History API, routing request to and from the aplication.
    @class Router
  ###
  module.exports = class Router
  
    ###*
      Array storing all the routes defined in the application's route file.
  
      @property {Array} routes
    ###
    routes: []
  
    ###*
      If false, doesn't handle the url route.
  
      @property {Boolean} trigger
    ###
    trigger: true
  
    ###*
    @class Router
    @constructor
    @param @the {Theoricus} Shortcut for app's instance.
    @param @on_change {Function} state/url change handler.
    ###
    constructor:( @the, @Routes, @on_change )->
      Factory = @the.factory
  
      for route, opts of @Routes.routes
        @map route, opts.to, opts.at, opts.el, @
  
      History.Adapter.bind window, 'statechange', =>
        @route History.getState()
  
      setTimeout =>
        url = window.location.pathname
        url = @Routes.root if url == "/"
        @run url
      , 1
  
    ###*
      Create and store a route within `routes` array.
      @method map
      @param route {String} Url state.
      @param to {String} Controller '/' action to which the route will be sent.
      @param at {String} Route to be called as a dependency.
      @param el {String} CSS selector to define where the template will be rendered.
    ###
    map:( route, to, at, el )->
      @routes.push route = new Route route, to, at, el, @
      return route
  
    ###*
      Handle the url state.
      @method route
      @param state {Object} HTML5 pushstate state
    ###
    route:( state )->
  
      if @trigger
  
        # url from HistoryJS
        url = state.hash || state.title
  
        # FIXME: quickfix for IE8 bug
        url = url.replace( '.', '' )
  
        #remove base path from incoming url
        ( url = url.replace @the.base_path, '' ) if @the.base_path?
  
        # removes the prepended '.' from HistoryJS
        url = url.slice 1 if (url.slice 0, 1) is '.'
  
        # adding back the first slash '/' in cases it's removed by HistoryJS
        url = "/#{url}" if (url.slice 0, 1) isnt '/'
  
        # fallback to root url in case user enter the '/'
        url = @Routes.root if url == "/"
  
        # search in all defined routes
        for route in @routes
          if route.test url
            return @on_change route, url
  
        # if none is found, tries to render based on default
        # controller/action settings
        url_parts = (url.replace /^\//m, '').split '/'
        controller_name = url_parts[0]
        action_name = url_parts[1] or 'index'
  
        @the.factory.controller controller_name, (controller)=>
  
          # if controller is found, route call to it
          if controller?
            route = @map url, "#{controller_name}/#{action_name}", null, 'body'
            return @on_change route, url
  
          # otherwise renders the not found route
          else
  
            for route in @routes
              if route.test @Routes.notfound
                return @on_change route, url
  
      @trigger = true
  
    ###*
      Change the url state.
  
      @method navigate
      @param url {String} New url state.
      @param [trigger=true] {String} If false,
      @param [replace=false] {String} If true, pushes a new state to the browser.
    ###
  
    navigate:( url, trigger = true, replace = false )->
  
      if not window.history.pushState
        return window.location = url
  
      @trigger = trigger
  
      action   = if replace then "replaceState" else "pushState"
      History[action] null, null, url
  
    ###*
      Set the url if the browser doesn't support HTML5 pushstate.
  
      @method run
      @param url {String} New url state.
      @param [trigger=true] {String} If false, doesn't handle the url's state.
    ###
    run:( url, trigger = true )=>
      ( url = url.replace @the.base_path, '' ) if @the.base_path?
  
      url = url.replace /\/$/g, ''
  
      @trigger = trigger
      @route { title: url }
  
    ###*
      If `index` is negative go back through browser history `index` times, if `index` is positive go forward through browser history `index` times.
  
      @method go
      @param index {Number}
    ###
    go:( index )->
      History.go index
  
    ###*
      Go back once through browser history.
  
      @method back
    ###
    back:()->
      History.back()
  
    ###*
      Go forward once through browser history.
  
      @method forward
    ###
    forward:()->
      History.forward()
  