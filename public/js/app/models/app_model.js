/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/models/app_model', ['require', 'exports', 'module', 'theoricus/mvc/model'], function(require, exports, module) {
  var AppModel, Model, _ref;
  Model = require('theoricus/mvc/model');
  return exports.module = AppModel = (function(_super) {
    __extends(AppModel, _super);

    function AppModel() {
      _ref = AppModel.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    return AppModel;

  })(Model);
});
/*
//@ sourceMappingURL=app_model.map
*/