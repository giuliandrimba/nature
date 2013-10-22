/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('app/views/pages/menu', ['require', 'exports', 'module', 'templates/pages/menu'], function(require, exports, module) {
  var Menu, Template;
  Template = require('templates/pages/menu');
  return module.exports = Menu = (function() {
    function Menu(at) {
      this.show = __bind(this.show, this);
      this.hide = __bind(this.hide, this);
      this.out = __bind(this.out, this);
      this.over = __bind(this.over, this);
      this.on_resize = __bind(this.on_resize, this);
      this.el = $(Template());
      $(at).append(this.el);
      this.setup();
    }

    Menu.prototype.on_resize = function() {
      this.el.css({
        top: this.window.height() - this.el.height(),
        width: this.window.width()
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
      this.events();
      return this.arrow.css({
        top: 100
      });
    };

    Menu.prototype["in"] = function() {
      return TweenLite.to(this.arrow, 0.5, {
        css: {
          top: 10
        },
        ease: Back.easeOut
      });
    };

    Menu.prototype.events = function() {
      this.window.bind("resize", this.on_resize);
      this.el.bind("mouseenter", this.show);
      this.el.bind("mouseleave", this.hide);
      this.menu.find("a").bind("mouseenter", this.over);
      return this.menu.find("a").bind("mouseleave", this.out);
    };

    Menu.prototype.over = function(e) {
      var bt;
      bt = $(e.currentTarget);
      if (bt.hasClass("active")) {
        return;
      }
      TweenLite.to(bt.find(".white_dot"), 0.15, {
        css: {
          width: 1,
          height: 1,
          marginLeft: -1,
          marginTop: -1
        }
      });
      return TweenLite.to(bt.find(".dot"), 0.15, {
        css: {
          opacity: 0
        }
      });
    };

    Menu.prototype.out = function(e) {
      var bt;
      bt = $(e.currentTarget);
      if (bt.hasClass("active")) {
        return;
      }
      TweenLite.to(bt.find(".white_dot"), 0.15, {
        css: {
          width: 25,
          height: 25,
          marginLeft: -(26 / 2),
          marginTop: -(26 / 2)
        }
      });
      return TweenLite.to(bt.find(".dot"), 0.15, {
        css: {
          opacity: 1
        }
      });
    };

    Menu.prototype.hide = function() {
      var amount, delay, distance, i, li, total_delay, _i, _len, _ref, _results;
      TweenLite.to(this.arrow, 0.5, {
        css: {
          top: 20
        },
        ease: Expo.easeOut,
        delay: 0.4
      });
      amount = this.menu.find("li").length;
      total_delay = amount / 2;
      delay = 0;
      distance = 0;
      this.delay_v = 0;
      _ref = this.menu.find("li a");
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        li = _ref[i];
        distance = total_delay - Math.abs(total_delay - this.delay_v);
        this.delay_v += 1;
        delay = distance / 500;
        li = $(li);
        _results.push(TweenLite.to(li, 0.4, {
          css: {
            top: 150
          },
          ease: Back.easeIn,
          delay: i * delay
        }));
      }
      return _results;
    };

    Menu.prototype.show = function() {
      var amount, delay, distance, i, li, total_delay, _i, _len, _ref, _results;
      TweenLite.to(this.arrow, 0.5, {
        css: {
          top: 150
        },
        ease: Expo.easeOut
      });
      amount = this.menu.find("li").length;
      total_delay = amount / 2;
      delay = 0;
      distance = 0;
      this.delay_v = 0;
      _ref = this.menu.find("li a");
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        li = _ref[i];
        distance = total_delay - Math.abs(total_delay - this.delay_v);
        this.delay_v += 1;
        delay = distance / 500;
        li = $(li);
        _results.push(TweenLite.to(li, 0.4, {
          css: {
            top: 20
          },
          ease: Back.easeOut,
          delay: i * delay
        }));
      }
      return _results;
    };

    return Menu;

  })();
});
/*
//@ sourceMappingURL=menu.map
*/