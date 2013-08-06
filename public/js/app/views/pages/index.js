/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/pages/index', ['require', 'exports', 'module', 'app/views/pages/menu', 'styles/pages/index', 'app/views/app_view'], function(require, exports, module) {
  var AppView, Index, Menu, Style;
  AppView = require('app/views/app_view');
  Style = require('styles/pages/index');
  Menu = require('app/views/pages/menu');
  return module.exports = Index = (function(_super) {
    __extends(Index, _super);

    Index.prototype.title = "Codeman _Labs";

    Index.prototype.after_render = function() {
      return this.setup();
    };

    Index.prototype.setup = function() {
      this.wrapper = $(this.el).find(".wrapper");
      this.window = $(window);
      this.menu = new Menu(".footer");
      return this.logo = this.el.find(".logo-labs");
    };

    Index.prototype.before_in = function() {
      return this.logo.css({
        opacity: 0
      });
    };

    Index.prototype.on_resize = function() {
      this.wrapper.css({
        width: this.window.width(),
        height: this.window.height()
      });
      return this.menu.on_resize();
    };

    Index.prototype["in"] = function() {
      var _this = this;
      Index.__super__["in"].apply(this, arguments);
      TweenLite.to(this.logo, 0, {
        css: {
          opacity: 1
        },
        delay: 0.1
      });
      this.logo.spritefy("logo-labs", {
        duration: 1,
        count: 1,
        onComplete: function() {
          return _this.menu["in"]();
        }
      });
      return this.logo.animation.play();
    };

    function Index() {
      this.on_resize = __bind(this.on_resize, this);
    }

    return Index;

  })(AppView);
});
/*
//@ sourceMappingURL=index.map
*/