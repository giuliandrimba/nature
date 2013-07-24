/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/pages/index', ['require', 'exports', 'module', 'styles/pages/index', 'app/views/app_view'], function(require, exports, module) {
  var AppView, Index, Style, _ref;
  AppView = require('app/views/app_view');
  Style = require('styles/pages/index');
  return module.exports = Index = (function(_super) {
    __extends(Index, _super);

    function Index() {
      _ref = Index.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    return Index;

  })(AppView);
});
/*
//@ sourceMappingURL=index.map
*/