/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/controllers/pages', ['require', 'exports', 'module', 'app/models/page', 'app/controllers/app_controller'], function(require, exports, module) {
  var AppController, Page, Pages, _ref;
  AppController = require('app/controllers/app_controller');
  Page = require('app/models/page');
  return module.exports = Pages = (function(_super) {
    __extends(Pages, _super);

    function Pages() {
      _ref = Pages.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DEFAULT ACTION BEHAVIOR
      Override it to take control and customize as you wish
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    */


    /* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      EXAMPLES
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    */


    Pages.prototype.collisions = function() {
      return this.render("circles/collisions");
    };

    Pages.prototype.circular_motion = function() {
      return this.render("circles/circular_motion");
    };

    return Pages;

  })(AppController);
});
/*
//@ sourceMappingURL=pages.map
*/