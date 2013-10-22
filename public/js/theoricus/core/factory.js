/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/core/factory', ['require', 'exports', 'module', 'theoricus/mvc/controller', 'theoricus/mvc/view', 'theoricus/mvc/model'], function(require, exports, module) {
  /**
    Core module
    @module core
  */

  var Controller, Factory, Model, View;
  Model = require('theoricus/mvc/model');
  View = require('theoricus/mvc/view');
  Controller = require('theoricus/mvc/controller');
  /**
    Factory is responsible for loading/creating the MVC classes.
  
    @class Factory
  */

  return module.exports = Factory = (function() {
    /**
      Store the loaded controllers.
      @property controllers {Array}
    */

    Factory.prototype.controllers = {};

    /**
    @class Factory
    @constructor
    @param the {Theoricus} Shortcut for app's instance
    */


    function Factory(the) {
      this.the = the;
      Model.Factory = this;
    }

    /**
    Returns an instantiated Model.
      
    @method model
    @param name {String} Model name.
    @param init {Object} Default properties to be setted in the model instance.
    @param fn {Function} Callback function returning the model instance.
    */


    Factory.model = Factory.prototype.model = function(name, init, fn) {
      var classname, classpath,
        _this = this;
      if (init == null) {
        init = {};
      }
      classname = name.camelize();
      classpath = ("app/models/" + name).toLowerCase();
      return require(['app/models/app_model', classpath], function(AppModel, NewModel) {
        var model, prop, value;
        model = new NewModel;
        if (model == null) {
          model = new AppModel;
        }
        model.classpath = classpath;
        model.classname = classname;
        for (prop in init) {
          value = init[prop];
          model[prop] = value;
        }
        return fn(model);
      }, function(err) {
        console.error('Model not found: ' + classpath);
        return fn(null);
      });
    };

    /**
    Returns an instantiated View.
      
    @method view
    @param path {String} Path to the view file.
    @param fn {Function} Callback function returning the view instance.
    */


    Factory.prototype.view = function(path, fn) {
      var classname, classpath, namespace, parts,
        _this = this;
      classname = (parts = path.split('/')).pop().camelize();
      namespace = parts[parts.length - 1];
      classpath = "app/views/" + path;
      return require(['app/views/app_view', classpath], function(AppView, View) {
        var msg, view;
        if (!((view = new View) instanceof View)) {
          msg = "" + classpath + " is not a View instance - you probably forgot to ";
          msg += "extend thoricus/mvc/View";
          console.error(msg);
        }
        if (view == null) {
          view = new AppView;
        }
        view._boot(_this.the);
        view.classpath = classpath;
        view.classname = classname;
        view.namespace = namespace;
        return fn(view);
      }, function(err) {
        console.error('View not found: ' + classpath);
        return fn(null);
      });
    };

    /**
    Returns an instantiated Controller.
      
    @method controller
    @param name {String} Controller name.
    @param fn {Function} Callback function returning the controller instance.
    */


    Factory.prototype.controller = function(name, fn) {
      var classname, classpath,
        _this = this;
      classname = name.camelize();
      classpath = "app/controllers/" + name;
      if (this.controllers[classpath] != null) {
        return fn(this.controllers[classpath]);
      } else {
        return require([classpath], function(Controller) {
          var controller, msg;
          if (!((controller = new Controller) instanceof Controller)) {
            msg = "" + classpath + " is not a Controller instance - you probably ";
            msg += "forgot to extend thoricus/mvc/Controller";
            console.error(msg);
          }
          controller.classpath = classpath;
          controller.classname = classname;
          controller._boot(_this.the);
          _this.controllers[classpath] = controller;
          return fn(_this.controllers[classpath]);
        }, function(err) {
          console.error('Controller not found: ' + classpath);
          return fn(null);
        });
      }
    };

    /**
    Returns an AMD compiled template.
      
    @method template
    @param path {String} Path to the template.
    @param fn {Function} Callback function returning the template string.
    */


    Factory.template = Factory.prototype.template = function(path, fn) {
      return require(['templates/' + path], function(template) {
        return fn(template);
      }, function(err) {
        console.error('Template not found: ' + path);
        return fn(null);
      });
    };

    /**
    Returns an AMD compiled style.
      
    @method style
    @param path {String} Path to the style.
    @param fn {Function} Callback function returning the style string.
    */


    Factory.style = Factory.prototype.style = function(path, fn) {
      return require(['styles/' + path], function(style) {
        return fn(style);
      }, function(err) {
        console.error('Style not found: ' + path);
        return fn(null);
      });
    };

    return Factory;

  })();
});
/*
//@ sourceMappingURL=factory.map
*/