/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/core/process', ['require', 'exports', 'module', 'theoricus/mvc/view', 'theoricus/utils/string_util'], function(require, exports, module) {
  /**
    Core module
    @module core
  */

  var Process, StringUtil, View;
  StringUtil = require('theoricus/utils/string_util');
  View = require('theoricus/mvc/view');
  /**
    Responsible for executing the controller render action based on the {{#crossLink "Router"}}{{/crossLink}} information.
    @class Process
  */

  return module.exports = Process = (function() {
    /**
    Route controller instance.
      
    @property {Controller} controller
    */

    Process.prototype.controller = null;

    /**
    Route storing the information which will be used to render the view.
    
    @property {Route} route
    */


    Process.prototype.route = null;

    /**
    Stores the `@route` dependency url.
    
    @property {String} dependency
    */


    Process.prototype.dependency = null;

    /**
    Will set be true in the run method, right before the action execution, and set to false right after the action is executed. this way the navigate method on controller can abort the process prematurely as needed.
    
    @property {Boolean} is_in_the_middle_of_running_an_action
    */


    Process.prototype.is_in_the_middle_of_running_an_action = false;

    /**
    Stores the url parameters.
      
    @property {Object} params
    */


    Process.prototype.params = null;

    /**
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
    */


    function Process(the, processes, route, at, url, parent_process, fn) {
      var _this = this;
      this.the = the;
      this.processes = processes;
      this.route = route;
      this.at = at;
      this.url = url;
      this.parent_process = parent_process;
      this.initialize();
      this.the.factory.controller(this.route.controller_name, function(controller) {
        _this.controller = controller;
        return fn(_this, _this.controller);
      });
    }

    /**
    Evaluates the `@route` dependency.
    
    @method initialize
    */


    Process.prototype.initialize = function() {
      if (this.url === null && (this.parent_process != null)) {
        this.url = this.route.rewrite_url_with_parms(this.route.match, this.parent_process.params);
      }
      this.params = this.route.extract_params(this.url);
      if (this.at) {
        return this.dependency = this.route.rewrite_url_with_parms(this.at, this.params);
      }
    };

    /**
    Executes controller's action, in case it isn't declared executes a default one.
    
    @param after_run {Function} Callback to be called after the view was rendered.
    */


    Process.prototype.run = function(after_run) {
      var action,
        _this = this;
      this.is_in_the_middle_of_running_an_action = true;
      if (!this.controller[action = this.route.action_name]) {
        this.controller[action] = this.controller._build_action(this);
      }
      this.controller.process = this;
      this.after_run = function() {
        _this.controller.process = null;
        return after_run();
      };
      this.controller.after_render = this.after_run;
      this.controller[action](this.params);
      return this.is_in_the_middle_of_running_an_action = false;
    };

    /**
    Executes view's transition "out" method, wait for it to empty the dom element and then call a callback.
    
    @method destroy
    @param @after_destroy {Function} Callback to be called after the view was removed.
    */


    Process.prototype.destroy = function(after_destroy) {
      var action_name, controller_name, msg,
        _this = this;
      this.after_destroy = after_destroy;
      if (!(this.view instanceof View)) {
        controller_name = this.route.controller_name.camelize();
        action_name = this.route.action_name;
        msg = "Can't destroy View because it isn't a proper View instance. ";
        msg += "Check your `" + controller_name + "` controller, the action ";
        msg += "`" + action_name + "` must return a View instance.";
        console.error(msg);
        return;
      }
      return this.view.out(function() {
        _this.view.destroy();
        return typeof _this.after_destroy === "function" ? _this.after_destroy() : void 0;
      });
    };

    return Process;

  })();
});
/*
//@ sourceMappingURL=process.map
*/