/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('theoricus/core/processes', ['require', 'exports', 'module', 'lodash', 'theoricus/core/process', 'theoricus/core/router'], function(require, exports, module) {
  var Factory, Process, Processes, Router, _;
  Router = require('theoricus/core/router');
  Process = require('theoricus/core/process');
  _ = require('lodash');
  Factory = null;
  return module.exports = Processes = (function() {
    Processes.prototype.locked = false;

    Processes.prototype.disable_transitions = null;

    Processes.prototype.active_processes = [];

    Processes.prototype.dead_processes = [];

    Processes.prototype.pending_processes = [];

    /*
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
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

    /*
    1st
      
    Triggered on router chance
      
    @param [theoricus.core.Router] route
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

    /*
    3th
      
    Check which of the routes needs to stay active in order to render
    current process.
    The ones that doesn't, are pushed to dead_processes
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

    /*
    4th
      
    Destroy dead processes one by one ( passing the next destroy as callback )
    then run the pending proccess
    */


    Processes.prototype._destroy_dead_processes = function() {
      var process;
      if (this.dead_processes.length) {
        process = this.dead_processes.pop();
        process.destroy(this._destroy_dead_processes);
        return this.active_processes = _.reject(this.active_processes, function(p) {
          return p.route.match === process.route.match;
        });
      } else {
        return this._run_pending_processes();
      }
    };

    /*
    5th
    Execute run method of pending processes that are not active
    */


    Processes.prototype._run_pending_processes = function() {
      var found, process, search, _base;
      if (this.pending_processes.length) {
        process = this.pending_processes.pop();
        search = {
          route: {
            match: process.route.match
          }
        };
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
        window.crawler.is_rendered = true;
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