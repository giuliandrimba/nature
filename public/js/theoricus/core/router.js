/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('theoricus/core/router', ['require', 'exports', 'module', 'theoricus/core/route', 'theoricus/utils/string_util', 'history'], function(require, exports, module) {
  /**
    Core module
    @module core
  */

  var Factory, Route, Router, StringUril;
  StringUril = require('theoricus/utils/string_util');
  Route = require('theoricus/core/route');
  require('history');
  Factory = null;
  /**
    Proxies browser's History API, routing request to and from the aplication.
    @class Router
  */

  return module.exports = Router = (function() {
    /**
      Array storing all the routes defined in the application's route file.
      
      @property {Array} routes
    */

    Router.prototype.routes = [];

    /**
      If false, doesn't handle the url route.
      
      @property {Boolean} trigger
    */


    Router.prototype.trigger = true;

    /**
    @class Router
    @constructor
    @param @the {Theoricus} Shortcut for app's instance.
    @param @on_change {Function} state/url change handler.
    */


    function Router(the, Routes, on_change) {
      var opts, route, _ref,
        _this = this;
      this.the = the;
      this.Routes = Routes;
      this.on_change = on_change;
      this.run = __bind(this.run, this);
      Factory = this.the.factory;
      _ref = this.Routes.routes;
      for (route in _ref) {
        opts = _ref[route];
        this.map(route, opts.to, opts.at, opts.el, this);
      }
      History.Adapter.bind(window, 'statechange', function() {
        return _this.route(History.getState());
      });
      setTimeout(function() {
        var url;
        url = window.location.pathname;
        if (url === "/") {
          url = _this.Routes.root;
        }
        return _this.run(url);
      }, 1);
    }

    /**
      Create and store a route within `routes` array.
      @method map
      @param route {String} Url state.
      @param to {String} Controller '/' action to which the route will be sent.
      @param at {String} Route to be called as a dependency.
      @param el {String} CSS selector to define where the template will be rendered.
    */


    Router.prototype.map = function(route, to, at, el) {
      this.routes.push(route = new Route(route, to, at, el, this));
      return route;
    };

    /**
      Handle the url state.
      @method route
      @param state {Object} HTML5 pushstate state
    */


    Router.prototype.route = function(state) {
      var action_name, controller_name, route, url, url_parts, _i, _len, _ref,
        _this = this;
      if (this.trigger) {
        url = state.hash || state.title;
        url = url.replace('.', '');
        if (this.the.base_path != null) {
          url = url.replace(this.the.base_path, '');
        }
        if ((url.slice(0, 1)) === '.') {
          url = url.slice(1);
        }
        if ((url.slice(0, 1)) !== '/') {
          url = "/" + url;
        }
        if (url === "/") {
          url = this.Routes.root;
        }
        _ref = this.routes;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          route = _ref[_i];
          if (route.test(url)) {
            return this.on_change(route, url);
          }
        }
        url_parts = (url.replace(/^\//m, '')).split('/');
        controller_name = url_parts[0];
        action_name = url_parts[1] || 'index';
        this.the.factory.controller(controller_name, function(controller) {
          var _j, _len1, _ref1;
          if (controller != null) {
            route = _this.map(url, "" + controller_name + "/" + action_name, null, 'body');
            return _this.on_change(route, url);
          } else {
            _ref1 = _this.routes;
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              route = _ref1[_j];
              if (route.test(_this.Routes.notfound)) {
                return _this.on_change(route, url);
              }
            }
          }
        });
      }
      return this.trigger = true;
    };

    /**
      Change the url state.
      
      @method navigate
      @param url {String} New url state.
      @param [trigger=true] {String} If false,
      @param [replace=false] {String} If true, pushes a new state to the browser.
    */


    Router.prototype.navigate = function(url, trigger, replace) {
      var action;
      if (trigger == null) {
        trigger = true;
      }
      if (replace == null) {
        replace = false;
      }
      if (!window.history.pushState) {
        return window.location = url;
      }
      this.trigger = trigger;
      action = replace ? "replaceState" : "pushState";
      return History[action](null, null, url);
    };

    /**
      Set the url if the browser doesn't support HTML5 pushstate.
      
      @method run
      @param url {String} New url state.
      @param [trigger=true] {String} If false, doesn't handle the url's state.
    */


    Router.prototype.run = function(url, trigger) {
      if (trigger == null) {
        trigger = true;
      }
      if (this.the.base_path != null) {
        url = url.replace(this.the.base_path, '');
      }
      url = url.replace(/\/$/g, '');
      this.trigger = trigger;
      return this.route({
        title: url
      });
    };

    /**
      If `index` is negative go back through browser history `index` times, if `index` is positive go forward through browser history `index` times.
      
      @method go
      @param index {Number}
    */


    Router.prototype.go = function(index) {
      return History.go(index);
    };

    /**
      Go back once through browser history.
      
      @method back
    */


    Router.prototype.back = function() {
      return History.back();
    };

    /**
      Go forward once through browser history.
      
      @method forward
    */


    Router.prototype.forward = function() {
      return History.forward();
    };

    return Router;

  })();
});
/*
//@ sourceMappingURL=router.map
*/