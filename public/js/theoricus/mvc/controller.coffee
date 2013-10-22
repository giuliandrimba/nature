###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    MVC module
    @module mvc
  ###
  
  Model = require 'theoricus/mvc/model'
  View = require 'theoricus/mvc/view'
  Fetcher = require 'theoricus/mvc/lib/fetcher'
  
  ###*
    The controller is responsible for rendering the view.
  
    It receives the URL params, to be used for Model instantiation.
  
    The controller actions are mapped with the URL states (routes) in the app `routes` file.
  
    @class Controller
  ###
  module.exports = class Controller
  
    ###
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
    ###
    ###*
      This function is executed by the Factory. It saves a `@the` reference inside the controller.
  
      @method _boot
      @param @the {Theoricus} Shortcut for app's instance
    ###
    _boot: ( @the ) -> @
  
    ###*
      Build a default action ( renders the view passing all model records as data) in case the controller doesn't have an action implemented for the current `process` call.
  
      @method _build_action
      @param process {Process} Current {{#crossLink "Process"}}{{/crossLink}} being executed.
    ###
    _build_action: ( process ) ->
      ( params, fn )=>
        controller_name = process.route.controller_name
        action_name = process.route.action_name
  
        model_name = controller_name.singularize()
        @the.factory.model model_name, null, (model)=>
          return unless model?
  
          view_folder = controller_name
          view_name   = action_name
  
          if model.all?
            @render "#{view_folder}/#{view_name}", model.all()
          else
            @render "#{view_folder}/#{view_name}"
  
    ###
    Renders to some view
  
    @param [String] path  Path to view on the app tree
    @param [String] data  data to be rendered on the template
    ###
  
    ###*
      Responsible for rendering the View.
  
      Usually, this method is executed in the controller action mapped with the `route`.
      
      @method render
      @param path {String} View's file path. 
      @param data {Object} Data to be passed to the view. 
  
      @example
          index:(id)-> # Controller action
              render "app/views/index", Model.first()
    ###
    render:( path, data )->
      @the.factory.view path, (view)=>
        
        @process.view = view
  
        view.process = @process
        view.after_in = @after_render
  
        if data instanceof Fetcher
          if data.loaded
            view._render data.records
          else
            data.onload = ( records ) =>
              view._render records
        else
          view._render data
  
  
    # ~> Shortcuts
  
    ###*
      Shortcut for application navigate.
  
      Navigate to the given URL.
  
      @method navigate
      @param url {String} URL to navigate to.
    ###
    navigate:( url )->
  
      # if redirect is called during the action execution, some operations must to
      # be performed in order to effectively kill the running process prematurely
      # before the router's navigation gets called
      # 
      # for this to work, your @render method must not be called, ie:
      # 
      # action:->
      #   if user_is_logged
      #     return @redirect '/signin'
      #   @render '/signedin'
      # 
      if @process.is_in_the_middle_of_running_an_action
  
        # kill current running process
        do @process.processes.active_processes.pop
  
        # fires after_render prematurely to wipe the fresh glue
        @after_render()
  
      # and redirects user
      @the.processes.router.navigate url