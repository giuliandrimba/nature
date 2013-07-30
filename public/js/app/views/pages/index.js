/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/pages/index', ['require', 'exports', 'module', 'app/views/pages/menu', 'styles/pages/index', 'app/views/app_view'], function(require, exports, module) {
  var AppView, Index, Menu, Style;
  AppView = require('app/views/app_view');
  Style = require('styles/pages/index');
  Menu = require('app/views/pages/menu');
  return module.exports = Index = (function(_super) {
    __extends(Index, _super);

    Index.prototype.title = "Codeman _Labs";

    Index.prototype.before_render = function() {
      return this.menu = new Menu;
    };

    function Index() {}

    return Index;

  })(AppView);
});
/*
//@ sourceMappingURL=index.map
*/