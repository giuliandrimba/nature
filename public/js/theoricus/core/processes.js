/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('theoricus/core/processes', ['require', 'exports', 'module', 'lodash', 'theoricus/core/process', 'theoricus/core/router'], function(require, exports, module) {
  /**
    Core module
    @module core
  */

  var Factory, Process, Processes, Router, _;
  Router = require('theoricus/core/router');
  Process = require('theoricus/core/process');
  _ = require('lodash');
  Factory = null;
  return module.exports = Processes = (function() {
    /**
    Block the url state to be changed. Useful if there is a current {{#crossLink "Process"}}{{/crossLink}} being executed.
      
    @property {Boolean} locked
    */

    Processes.prototype.locked = false;

    Processes.prototype.disable_transitions = null;

    Processes.prototype.active_processes = [];

    Processes.prototype.dead_processes = [];

    Processes.prototype.pending_processes = [];

    /**
    Responsible for handling the page/url change. It removes last Process, runs new Process dependencies, and then add the required Process. 
      
    __Execution order__
      
    1. `_on_router_change`
      
    2. `_filter_pending_processes`
      
    3. `_filter_dead_processes`
      
    4. `_destroy_dead_processes` - one by one, waiting or not for callback (timing can be sync/async)
      
    6. `_run_pending_process` - one by one, waiting or not for callback (timing can be sync/async)
      
    @class Processes
    @constructor
    @param @the {Theoricus} Shortcut for app's instance.
    @param @Routes {Object} App Routes
    */


    function Processes(the, Routes) {
      var _this = this;
      this.the = the;
      this.Routes = Routes;
      this._run_pending_processes = __bind(this._run_pending_processes, this);
      this._destroy_dead_processes = __bind(this._destroy_dead_processes, this);
      this._on_router_change = __bind(this._on_router_change, this);
      Factory = this.the.factory;
      if (this.the.config.animate_at_startup === false) {
        this.disable_transitions = this.the.config.disable_transitions;
        this.the.config.disable_transitions = true;
      }
      $(document).ready(function() {
        return _this.router = new Router(_this.the, _this.Routes, _this._on_router_change);
      });
    }

    /**
    Executed when the route changes, it creates a {{#crossLink "Process"}}{{/crossLink}} to manipulate the route, removes the current process, and run the new process alongside its dependencies.
    
    @method _on_router_change
    @param route {Route} Route containing the controller and url state information.
    @param url {String} Current url state.
    */


    Processes.prototype._on_router_change = function(route, url) {
      var _this = this;
      if (this.locked) {
        return this.router.navigate(this.last_process.url, 0, 1);
      }
      this.locked = true;
      this.the.crawler.is_rendered = false;
      return new Process(this.the, this, route, route.at, url, null, function(process, controller) {
        _this.last_process = process;
        _this.pending_processes = [];
        return _this._filter_pending_processes(process, function() {
          _this._filter_dead_processes();
          return _this._destroy_dead_processes();
        });
      });
    };

    /*
    2nd
      
    Check if target scope ( for rendering ) exists
    If yes adds it to pending_process list
    If no  throws an error
      
    @param [theoricus.core.Process] process
    */


    /**
    */


    Processes.prototype._filter_pending_processes = function(process, after_filter) {
      var _this = this;
      this.pending_processes.push(process);
      if (process.dependency != null) {
        return this._find_dependency(process, function(dependency) {
          var a, b;
          if (dependency != null) {
            return _this._filter_pending_processes(dependency, after_filter);
          } else {
            a = process.dependecy;
            b = process.route.at;
            console.error("Dependency not found for " + a + " and/or " + b);
            return console.log(process);
          }
        });
      } else {
        return after_filter();
      }
    };

    /**
    Finds the dependency of the given {{#crossLink "Process"}}{{/crossLink}}
      
    @method _find_dependency
    @param process {Process} Processto find the dependency.
    @param after_find {Function} Callback to be called after the dependency has been found.
    */


    Processes.prototype._find_dependency = function(process, after_find) {
      var at, dep, dependency, params,
        _this = this;
      dependency = process.dependency;
      dep = _.find(this.active_processes, function(item) {
        return item.url === dependency;
      });
      if (dep != null) {
        return after_find(dep);
      }
      dep = _.find(this.router.routes, function(item) {
        return item.test(dependency);
      });
      if (dep != null) {
        params = dep.extract_params(process.dependency);
        at = dep.rewrite_url_with_parms(dep.at, params);
        return new Process(this.the, this, dep, at, dependency, process, function(process) {
          return after_find(process);
        });
      }
      return after_find(null);
    };

    /**
    Check which of the processes needs to stay active in order to render current process.
    The ones that doesn't, are pushed to dead_processes.
      
    @method _filter_dead_processes
    */


    Processes.prototype._filter_dead_processes = function() {
      var active, process, url, _i, _len, _ref, _results;
      this.dead_processes = [];
      _ref = this.active_processes;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        active = _ref[_i];
        process = _.find(this.pending_processes, function(item) {
          return item.url === active.url;
        });
        if (process != null) {
          url = process.url;
          if ((url != null) && url !== active.url) {
            _results.push(this.dead_processes.push(active));
          } else {
            _results.push(void 0);
          }
        } else {
          _results.push(this.dead_processes.push(active));
        }
      }
      return _results;
    };

    /**
    Destroy the dead processes (doesn't need to be active) one by one, then run the pending process.
      
    @method _destroy_dead_processes
    */


    Processes.prototype._destroy_dead_processes = function() {
      var process;
      if (this.dead_processes.length) {
        process = this.dead_processes.pop();
        this.active_processes = _.reject(this.active_processes, function(p) {
          return p.route.match === process.route.match;
        });
        return process.destroy(this._destroy_dead_processes);
      } else {
        return this._run_pending_processes();
      }
    };

    /**
    Run the processes that are not active yet.
      
    @method _run_pending_processes
    */


    Processes.prototype._run_pending_processes = function() {
      var found, process, _base;
      if (this.pending_processes.length) {
        process = this.pending_processes.pop();
        found = _.find(this.active_processes, function(found_process) {
          return found_process.route.match === process.route.match;
        });
        if (found == null) {
          this.active_processes.push(process);
          return process.run(this._run_pending_processes);
        } else {
          return this._run_pending_processes();
        }
      } else {
        this.locked = false;
        this.the.crawler.is_rendered = true;
        if (this.disable_transitions != null) {
          this.the.config.disable_transitions = this.disable_transitions;
          this.disable_transitions = null;
        }
        return typeof (_base = _.last(this.active_processes)).on_activate === "function" ? _base.on_activate() : void 0;
      }
    };

    return Processes;

  })();
});
/*
//@ sourceMappingURL=processes.map
*/