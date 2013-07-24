/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/controllers/app_controller', ['require', 'exports', 'module', 'theoricus/mvc/controller'], function(require, exports, module) {
  var AppController, Controller, _ref;
  Controller = require('theoricus/mvc/controller');
  return exports.module = AppController = (function(_super) {
    __extends(AppController, _super);

    function AppController() {
      _ref = AppController.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    return AppController;

  })(Controller);
});
/*
//@ sourceMappingURL=app_controller.map
*/