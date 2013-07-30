/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/app_view', ['require', 'exports', 'module', 'app/config/vendors', 'theoricus/mvc/view'], function(require, exports, module) {
  var AppView, Vendors, View, _ref;
  View = require('theoricus/mvc/view');
  Vendors = require('app/config/vendors');
  return exports.module = AppView = (function(_super) {
    __extends(AppView, _super);

    function AppView() {
      _ref = AppView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AppView.prototype.set_triggers = function() {
      var _this = this;
      AppView.__super__.set_triggers.call(this);
      return this.el.find('a[href*="/"]').each(function(index, item) {
        return $(item).click(function(event) {
          _this.navigate($(event.delegateTarget).attr('href'));
          return false;
        });
      });
    };

    return AppView;

  })(View);
});
/*
//@ sourceMappingURL=app_view.map
*/