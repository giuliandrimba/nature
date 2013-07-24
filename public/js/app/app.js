/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/app', ['require', 'exports', 'module', 'app/config/routes', 'app/config/settings', 'theoricus/theoricus'], function(require, exports, module) {
  var App, Routes, Settings, Theoricus;
  Theoricus = require('theoricus/theoricus');
  Settings = require('app/config/settings');
  Routes = require('app/config/routes');
  module.exports = App = (function(_super) {
    __extends(App, _super);

    function App(Settings, Routes) {
      App.__super__.constructor.call(this, Settings, Routes);
      this.start();
    }

    return App;

  })(Theoricus);
  return new App(Settings, Routes);
});
/*
//@ sourceMappingURL=app.map
*/