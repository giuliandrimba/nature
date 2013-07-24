###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  StringUtil = require 'theoricus/utils/string_util'
  View = require 'theoricus/mvc/view'
  
  ###
  Responsible for "running" a [theoricus.core.Route] Route
  
  @author {https://github.com/arboleya arboleya}
  ###
  module.exports = class Process
  
    # @property [theoricus.mvc.Controller] controller
    controller: null
  
    # @property [theoricus.core.Route] route
    route: null
  
    # parent process (in which this one depends)
    dependency: null
  
    # will set be true in the run method, right before the action execution, and
    # set to false right after the action is executed. this way the navigate
    # method on controller can abort the process prematurely as needed.
    is_in_the_middle_of_running_an_action: false
  
    # process params
    params: null
  
    ###
    Instantiate controller responsible for the route
    
    @param [theoricus.Theoricus] @the   Shortcut for current app's instace
    @route [theoricus.core.Route] @route Route responsible for the process
    ###
    constructor:( @the, @processes, @route, @at, @url, @parent_process, fn )->
  
      # initialize process logic
      do @initialize
  
      # instantiates controller and fires the constructor callback
      @the.factory.controller @route.controller_name, ( @controller )=>
        fn @, @controller
  
  
    initialize:->
      if @url is null and @parent_process?
        @url = @route.rewrite_url_with_parms @route.match, @parent_process.params
  
      # initializes params object
      @params = @route.extract_params @url
  
      # evaluates dependency route
      if @at
        @dependency = @route.rewrite_url_with_parms @at, @params
  
  
    ###
    Executes controller's action, in case it isn't declared executes an 
    standard one.
    
    @return [theoricus.mvc.View] view
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
  
      # mounts an array with action params followed by a callback
      callback = (@view)=>
        unless @view instanceof View
          controller_name = @route.controller_name.camelize()
          msg = "Check your `#{controller_name}` controller, the action "
          msg += "`#{action}` must return a View instance."
          console.error msg
  
      # sets the callback
      @controller.after_render = @after_run
  
      # executes action
      @controller[ action ] @params
  
      # sets is_in_the_middle_of_running_an_action=false
      @is_in_the_middle_of_running_an_action = false
  
  
  
    ###
    Executes view's transition "out" method, wait for its end
    empty the dom element and then call a callback
    
    @return [theoricus.mvc.View] view
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