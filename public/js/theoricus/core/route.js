/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/core/route', ['require', 'exports', 'module'], function(require, exports, module) {
  var Route;
  return module.exports = Route = (function() {
    Route.named_param_reg = /:\w+/g;

    Route.splat_param_reg = /\*\w+/g;

    Route.prototype.matcher = null;

    Route.prototype.match = null;

    Route.prototype.to = null;

    Route.prototype.at = null;

    Route.prototype.el = null;

    Route.prototype.controller_name = null;

    Route.prototype.action_name = null;

    Route.prototype.param_names = null;

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

    Route.prototype.rewrite_url_with_parms = function(url, params) {
      var key, reg, value;
      for (key in params) {
        value = params[key];
        reg = new RegExp("[:\\*]+" + key, 'g');
        url = url.replace(reg, value);
      }
      return url;
    };

    Route.prototype.test = function(url) {
      return this.matcher.test(url);
    };

    return Route;

  })();
});
/*
//@ sourceMappingURL=route.map
*/