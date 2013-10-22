/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/mvc/controller', ['require', 'exports', 'module', 'theoricus/mvc/lib/fetcher', 'theoricus/mvc/view', 'theoricus/mvc/model'], function(require, exports, module) {
  /**
    MVC module
    @module mvc
  */

  var Controller, Fetcher, Model, View;
  Model = require('theoricus/mvc/model');
  View = require('theoricus/mvc/view');
  Fetcher = require('theoricus/mvc/lib/fetcher');
  /**
    The controller is responsible for rendering the view.
  
    It receives the URL params, to be used for Model instantiation.
  
    The controller actions are mapped with the URL states (routes) in the app `routes` file.
  
    @class Controller
  */

  return module.exports = Controller = (function() {
    function Controller() {}

    /*
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
    */


    /**
      This function is executed by the Factory. It saves a `@the` reference inside the controller.
      
      @method _boot
      @param @the {Theoricus} Shortcut for app's instance
    */


    Controller.prototype._boot = function(the) {
      this.the = the;
      return this;
    };

    /**
      Build a default action ( renders the view passing all model records as data) in case the controller doesn't have an action implemented for the current `process` call.
      
      @method _build_action
      @param process {Process} Current {{#crossLink "Process"}}{{/crossLink}} being executed.
    */


    Controller.prototype._build_action = function(process) {
      var _this = this;
      return function(params, fn) {
        var action_name, controller_name, model_name;
        controller_name = process.route.controller_name;
        action_name = process.route.action_name;
        model_name = controller_name.singularize();
        return _this.the.factory.model(model_name, null, function(model) {
          var view_folder, view_name;
          if (model == null) {
            return;
          }
          view_folder = controller_name;
          view_name = action_name;
          if (model.all != null) {
            return _this.render("" + view_folder + "/" + view_name, model.all());
          } else {
            return _this.render("" + view_folder + "/" + view_name);
          }
        });
      };
    };

    /*
    Renders to some view
      
    @param [String] path  Path to view on the app tree
    @param [String] data  data to be rendered on the template
    */


    /**
      Responsible for rendering the View.
      
      Usually, this method is executed in the controller action mapped with the `route`.
      
      @method render
      @param path {String} View's file path. 
      @param data {Object} Data to be passed to the view. 
      
      @example
          index:(id)-> # Controller action
              render "app/views/index", Model.first()
    */


    Controller.prototype.render = function(path, data) {
      var _this = this;
      return this.the.factory.view(path, function(view) {
        _this.process.view = view;
        view.process = _this.process;
        view.after_in = _this.after_render;
        if (data instanceof Fetcher) {
          if (data.loaded) {
            return view._render(data.records);
          } else {
            return data.onload = function(records) {
              return view._render(records);
            };
          }
        } else {
          return view._render(data);
        }
      });
    };

    /**
      Shortcut for application navigate.
      
      Navigate to the given URL.
      
      @method navigate
      @param url {String} URL to navigate to.
    */


    Controller.prototype.navigate = function(url) {
      if (this.process.is_in_the_middle_of_running_an_action) {
        this.process.processes.active_processes.pop();
        this.after_render();
      }
      return this.the.processes.router.navigate(url);
    };

    return Controller;

  })();
});
/*
//@ sourceMappingURL=controller.map
*/