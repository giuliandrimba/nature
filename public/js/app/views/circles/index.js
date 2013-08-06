/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/circles/index', ['require', 'exports', 'module', 'app/libs/board/basic/circle', 'app/libs/board/scene', 'styles/circles/index', 'app/views/app_view'], function(require, exports, module) {
  var AppView, Circle, Index, Scene, Style, _ref;
  AppView = require('app/views/app_view');
  Style = require('styles/circles/index');
  Scene = require('app/libs/board/scene');
  Circle = require('app/libs/board/basic/circle');
  return module.exports = Index = (function(_super) {
    __extends(Index, _super);

    function Index() {
      this.add_target = __bind(this.add_target, this);
      this.on_tick = __bind(this.on_tick, this);
      _ref = Index.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Index.prototype.events = {
      "#canvas click": "add_target"
    };

    Index.prototype.mouse_x = 0;

    Index.prototype.mouse_y = 0;

    Index.prototype.after_render = function() {
      this.window = $(window);
      this.canvas = $("#canvas");
      this.scene = new Scene("canvas", "#000");
      this.scene.on("tick", this.on_tick);
      this.red = new Circle(40, "#ff0000", 100, 100);
      this.red.speed = 5;
      return this.scene.add(this.red);
    };

    Index.prototype.on_tick = function() {
      this.red.x += 1;
      return this.red.y += 1;
    };

    Index.prototype.add_target = function(e) {
      this.mouse_x = e.pageX;
      this.mouse_y = e.pageY;
      this.target = new Circle(10, "#ff0000", this.mouse_x, this.mouse_y);
      return this.scene.add(this.target);
    };

    Index.prototype.on_resize = function() {
      this.canvas.attr("width", this.window.width());
      return this.canvas.attr("height", this.window.height());
    };

    return Index;

  })(AppView);
});
/*
//@ sourceMappingURL=index.map
*/