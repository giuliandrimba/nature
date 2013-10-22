###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    Core module
    @module core
  ###
  
  StringUtil = require 'theoricus/utils/string_util'
  View = require 'theoricus/mvc/view'
  
  ###*
    Responsible for executing the controller render action based on the {{#crossLink "Router"}}{{/crossLink}} information.
    @class Process
  ###
  module.exports = class Process
  
    ###*
    Route controller instance.
  
    @property {Controller} controller
    ###
    controller: null
  
    ###*
    Route storing the information which will be used to render the view.
    
    @property {Route} route
    ###
    route: null
  
    ###*
    Stores the `@route` dependency url.
    
    @property {String} dependency
    ###
    dependency: null
  
    ###*
    Will set be true in the run method, right before the action execution, and set to false right after the action is executed. this way the navigate method on controller can abort the process prematurely as needed.
    
    @property {Boolean} is_in_the_middle_of_running_an_action
    ###
    is_in_the_middle_of_running_an_action: false
  
    ###*
    Stores the url parameters.
  
    @property {Object} params
    ###
    params: null
  
    ###*
    Responsible for executing the controller render action based on the {{#crossLink "Router"}}{{/crossLink}} information.
  
    @class Process
    @constructor
    @param @the {Theoricus} Shortcut for app's instance.
    @param @processes {Processes} Processes instance.
    @param @route {Route} Route to be manipulated.
    @param @at {Route} Route dependency.
    @param @url {String} Current url state.
    @param @parent_process {Process}
    @param fn {Function} Callback to be called after the dependency have been manipulated, and the controller loaded.
    ###
    constructor:( @the, @processes, @route, @at, @url, @parent_process, fn )->
  
      # initialize process logic
      do @initialize
  
      # instantiates controller and fires the constructor callback
      @the.factory.controller @route.controller_name, ( @controller )=>
        fn @, @controller
  
    ###*
    Evaluates the `@route` dependency.
    
    @method initialize
    ###
    initialize:->
      if @url is null and @parent_process?
        @url = @route.rewrite_url_with_parms @route.match, @parent_process.params
  
      # initializes params object
      @params = @route.extract_params @url
  
      # evaluates dependency route
      if @at
        @dependency = @route.rewrite_url_with_parms @at, @params
  
    ###*
    Executes controller's action, in case it isn't declared executes a default one.
    
    @param after_run {Function} Callback to be called after the view was rendered.
    ###
    run:( after_run )->
  
      # sets is_in_the_middle_of_running_an_action=true
      @is_in_the_middle_of_running_an_action = true
  
      # if action is not defined, defines the default action behaviour for it
      unless @controller[ action = @route.action_name ]
        @controller[ action ] = @controller._build_action @
  
      # inject the current process into controller
      @controller.process = @
  
      # creates callback to reset things
      @after_run = =>
        @controller.process = null
        after_run()
  
      # sets the callback
      @controller.after_render = @after_run
  
      # executes action
      @controller[ action ] @params
  
      # sets is_in_the_middle_of_running_an_action=false
      @is_in_the_middle_of_running_an_action = false
  
  
  
    ###*
    Executes view's transition "out" method, wait for it to empty the dom element and then call a callback.
    
    @method destroy
    @param @after_destroy {Function} Callback to be called after the view was removed.
    ###
    destroy:( @after_destroy )->
      # call the OUT transition with the given callback
      unless (@view instanceof View)
        controller_name = @route.controller_name.camelize()
        action_name = @route.action_name
        msg = "Can't destroy View because it isn't a proper View instance. "
        msg += "Check your `#{controller_name}` controller, the action "
        msg += "`#{action_name}` must return a View instance."
        console.error msg
        return
  
      @view.out =>
        @view.destroy()
        @after_destroy?()