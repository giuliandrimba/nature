###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  Model = require 'theoricus/mvc/model'
  Factory = null
  
  module.exports = class View
  
    # @property page title
    title: null
  
    # $ reference to dom element
    el: null
  
    # @property [String] class path
    classpath : null
  
    # @property [String] class name
    classname : null
  
    # @property [String] namespace
    namespace : null
    
    # @property [theoricus.core.Process] process
    process   : null
  
    ###
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
    ###
    _boot:( @the )->
      Factory = @the.factory
      @
  
    ###
    @param [Object] @data   Data to be passed to the template
    @param [Object] @el     Element where the view will be "attached/appended"
    ###
    _render:( data = {}, template )=>
      @data = 
        view: @
        params: @process.params
        data: data
  
      @before_render?(@data)
  
      @process.on_activate = =>
        @on_activate?()
        if @title?
          document.title = @title
  
      @el = $ @process.route.el
  
      unless template?
        tmpl_folder = @namespace.replace(/\./g, '/')
        tmpl_name   = @classname.underscore()
        template = "#{tmpl_folder}/#{tmpl_name}"
  
      @render_template template
  
    render_template:( template )->
      @the.factory.template template, ( template ) =>
  
        dom = template @data
        dom = @el.append dom
  
        # binds item if the data passed is a valid Model
        if (@data instanceof Model)
          @data.bind dom, !@the.config.autobind
        
        @set_triggers?()
        @after_render?(@data)
  
        @in()
  
        if @on_resize?
          $( window ).unbind 'resize', @_on_resize
          $( window ).bind   'resize', @_on_resize
          @on_resize()
  
    _on_resize:=>
      do @on_resize
  
    ###
    In case you defined @events in your view they will be automatically binded
    ###
    set_triggers: () =>
      return if not @events?
      for sel, funk of @events
        [all, sel, ev] = sel.match /(.*)[\s|\t]+([\S]+)$/m
        ( @el.find sel ).unbind ev, null, @[funk]
        ( @el.find sel ).bind   ev, null, @[funk]
  
    ###
    Triggers view "animation in", "@after_in" must be called in the end
    ###
    in:()->
      @before_in?()
      animate  = @the.config.enable_auto_transitions
      animate &= !@the.config.disable_transitions
      unless animate
        @after_in?()
      else
        @el.css "opacity", 0
        @el.animate {opacity: 1}, 300, => @after_in?()
  
    ###
    Triggers view "animation out", "after_out" must be called in the end
     @param [Function] after_out Callback function to be triggered in the end
    ###
    out:( after_out )->
      @before_out?()
      animate = @the.config.enable_auto_transitions
      animate &= !@the.config.disable_transitions
      unless animate
        after_out()
      else
        @el.animate {opacity: 0}, 300, after_out
  
    ###
    Destroy the view after the 'out' animation, the default behavior is to just
    empty it's container element.
  
    before_destroy will be called just before emptying it.
    ###
    destroy: () ->
      if @on_resize?
        $( window ).unbind 'resize', @_on_resize
  
      @before_destroy?()
      @el.empty()
  
    # ~> Shortcuts
  
    ###
    Shortcut for application navigate
  
    @param [String] url URL to navigate
    ###
    navigate:( url )->
      @the.processes.router.navigate url