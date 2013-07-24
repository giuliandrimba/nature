/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/core/process', ['require', 'exports', 'module', 'theoricus/mvc/view', 'theoricus/utils/string_util'], function(require, exports, module) {
  var Process, StringUtil, View;
  StringUtil = require('theoricus/utils/string_util');
  View = require('theoricus/mvc/view');
  /*
  Responsible for "running" a [theoricus.core.Route] Route
  
  @author {https://github.com/arboleya arboleya}
  */

  return module.exports = Process = (function() {
    Process.prototype.controller = null;

    Process.prototype.route = null;

    Process.prototype.dependency = null;

    Process.prototype.is_in_the_middle_of_running_an_action = false;

    Process.prototype.params = null;

    /*
    Instantiate controller responsible for the route
    
    @param [theoricus.Theoricus] @the   Shortcut for current app's instace
    @route [theoricus.core.Route] @route Route responsible for the process
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

    Process.prototype.initialize = function() {
      if (this.url === null && (this.parent_process != null)) {
        this.url = this.route.rewrite_url_with_parms(this.route.match, this.parent_process.params);
      }
      this.params = this.route.extract_params(this.url);
      if (this.at) {
        return this.dependency = this.route.rewrite_url_with_parms(this.at, this.params);
      }
    };

    /*
    Executes controller's action, in case it isn't declared executes an 
    standard one.
    
    @return [theoricus.mvc.View] view
    */


    Process.prototype.run = function(after_run) {
      var action, callback,
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
      callback = function(view) {
        var controller_name, msg;
        _this.view = view;
        if (!(_this.view instanceof View)) {
          controller_name = _this.route.controller_name.camelize();
          msg = "Check your `" + controller_name + "` controller, the action ";
          msg += "`" + action + "` must return a View instance.";
          return console.error(msg);
        }
      };
      this.controller.after_render = this.after_run;
      this.controller[action](this.params);
      return this.is_in_the_middle_of_running_an_action = false;
    };

    /*
    Executes view's transition "out" method, wait for its end
    empty the dom element and then call a callback
    
    @return [theoricus.mvc.View] view
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