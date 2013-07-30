/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('app/views/pages/menu', ['require', 'exports', 'module', 'styles/pages/menu', 'templates/pages/menu'], function(require, exports, module) {
  var Menu, Style, Template;
  Template = require('templates/pages/menu');
  Style = require('styles/pages/menu');
  return module.exports = Menu = (function() {
    function Menu(at) {
      this.show = __bind(this.show, this);
      this.hide = __bind(this.hide, this);
      this.on_resize = __bind(this.on_resize, this);
      this.el = $(Template());
      $(at).append(this.el);
      this.setup();
    }

    Menu.prototype.on_resize = function() {
      this.el.css({
        top: this.window.height() - this.el.height() - 25
      });
      return this.menu.css({
        left: this.wrapper.width() / 2 - this.menu.width() / 2
      });
    };

    Menu.prototype.setup = function() {
      this.window = $(window);
      this.wrapper = $(".wrapper");
      this.arrow = this.el.find(".arrow");
      this.menu = this.el.find(".nav");
      this.on_resize();
      return this.events();
    };

    Menu.prototype.events = function() {
      this.window.bind("resize", this.on_resize);
      this.el.bind("mouseenter", this.show);
      return this.el.bind("mouseleave", this.hide);
    };

    Menu.prototype.hide = function() {
      var delay, i, last_delay, li, _i, _len, _ref;
      delay = 0.07;
      last_delay = 0.4;
      _ref = this.menu.find("li a");
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        li = _ref[i];
        li = $(li);
        TweenLite.to(li, 0.4, {
          css: {
            top: 100
          },
          ease: Back.easeIn,
          delay: i * delay
        });
        delay -= 0.005;
      }
      return TweenLite.to(this.arrow, 0.5, {
        css: {
          top: 10
        },
        ease: Back.easeOut,
        delay: last_delay
      });
    };

    Menu.prototype.show = function() {
      var delay, i, li, _i, _len, _ref, _results;
      TweenLite.to(this.arrow, 0.5, {
        css: {
          top: 60
        },
        ease: Expo.easeOut
      });
      delay = 0.07;
      _ref = this.menu.find("li a");
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        li = _ref[i];
        li = $(li);
        TweenLite.to(li, 0.4, {
          css: {
            top: 10
          },
          ease: Back.easeOut,
          delay: i * delay
        });
        _results.push(delay -= 0.005);
      }
      return _results;
    };

    return Menu;

  })();
});
/*
//@ sourceMappingURL=menu.map
*/