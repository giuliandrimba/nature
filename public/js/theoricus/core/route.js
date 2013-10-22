/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/core/route', ['require', 'exports', 'module'], function(require, exports, module) {
  /**
    Core module
    @module core
  */

  /**
    
    Responsible for manipulating and validating url state.
  
    Stores the data defined in the application config `routes.coffee`
  
    @class Route
  */

  var Route;
  return module.exports = Route = (function() {
    /**
      
      Match named params
      
      @static
      @property named_param_reg {RegExp}
      @example
        "works/:id".match Route.named_param_reg # matchs ':id'
    */

    Route.named_param_reg = /:\w+/g;

    /**
      
      @static
      @property splat_param_reg {RegExp}
    */


    Route.splat_param_reg = /\*\w+/g;

    /**
      
      Regex responsible for parsing the url state.
      
      @property matcher {RegExp}
    */


    Route.prototype.matcher = null;

    /**
      
      Url state.
      
      @property match {String}
    */


    Route.prototype.match = null;

    /**
      
      Controller '/' action to which the route will be sent.
      
      @property to {String}
    */


    Route.prototype.to = null;

    /**
      
      Route to be called as a dependency.
      
      @property at {String}
    */


    Route.prototype.at = null;

    /**
      
      CSS selector to define where the template will be rendered.
      
      @property el {String}
    */


    Route.prototype.el = null;

    /**
      
      Store the controller name extracted from url.
      
      @property controller_name {String}
    */


    Route.prototype.controller_name = null;

    /**
      
      Store the controllers' action name extracted from url.
      
      @property action_name {String}
    */


    Route.prototype.action_name = null;

    /**
      
      Store the controllers' action parameters extracted from url.
      
      @property param_names {String}
    */


    Route.prototype.param_names = null;

    /**
      @class Route
      @constructor
      @param @match {String} Url state.
      @param @to {String} Controller '/' action to which the route will be sent.
      @param @at {String} Route to be called as a dependency.
      @param @el {String} CSS selector to define where the template will be rendered.
    */


    function Route(match, to, at, el) {
      var _ref;
      this.match = match;
      this.to = to;
      this.at = at;
      this.el = el;
      this.matcher = this.match.replace(Route.named_param_reg, '([^\/]+)');
      this.matcher = this.matcher.replace(Route.splat_param_reg, '(.*?)');
      this.matcher = new RegExp("^" + this.matcher + "$", 'm');
      _ref = to.split('/'), this.controller_name = _ref[0], this.action_name = _ref[1];
    }

    /**
    
      Extract the url named parameters.
      
      @method extract_params
      @param url {String}
    */


    Route.prototype.extract_params = function(url) {
      var index, key, param_names, params, params_values, val, value, _i, _j, _len, _len1, _ref;
      params = {};
      if ((param_names = this.match.match(/(:|\*)\w+/g)) != null) {
        for (index = _i = 0, _len = param_names.length; _i < _len; index = ++_i) {
          value = param_names[index];
          param_names[index] = value.substr(1);
        }
      } else {
        param_names = [];
      }
      params_values = (_ref = url.match(this.matcher)) != null ? _ref.slice(1 || []) : void 0;
      if (params_values != null) {
        for (index = _j = 0, _len1 = params_values.length; _j < _len1; index = ++_j) {
          val = params_values[index];
          key = param_names[index];
          params[key] = val;
        }
      }
      return params;
    };

    /**
      Returns a string with the url param names replaced by param values.
      
      @method rewrite_url_with_parms
      @param url {String}
      @param params {Object}
    */


    Route.prototype.rewrite_url_with_parms = function(url, params) {
      var key, reg, value;
      for (key in params) {
        value = params[key];
        reg = new RegExp("[:\\*]+" + key, 'g');
        url = url.replace(reg, value);
      }
      return url;
    };

    /**
      
      Test given url against the url state defined in the route.
      
      @method test
      @param url {String} Url to be tested.
    */


    Route.prototype.test = function(url) {
      return this.matcher.test(url);
    };

    return Route;

  })();
});
/*
//@ sourceMappingURL=route.map
*/