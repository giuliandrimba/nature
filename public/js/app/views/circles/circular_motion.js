/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/circles/circular_motion', ['require', 'exports', 'module', 'app/libs/board/geometry/path', 'app/libs/board/geometry/circle', 'app/libs/board/scene', 'styles/circles/circular_motion', 'app/views/app_view'], function(require, exports, module) {
  var AppView, Circle, CircularMotion, Path, Scene, Style, _ref;
  AppView = require('app/views/app_view');
  Style = require('styles/circles/circular_motion');
  Scene = require('app/libs/board/scene');
  Circle = require('app/libs/board/geometry/circle');
  Path = require('app/libs/board/geometry/path');
  return module.exports = CircularMotion = (function(_super) {
    __extends(CircularMotion, _super);

    function CircularMotion() {
      this.on_tick = __bind(this.on_tick, this);
      _ref = CircularMotion.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    CircularMotion.prototype.path_radius = 30;

    CircularMotion.prototype.after_render = function() {
      this.window = $(window);
      this.canvas = $("#canvas");
      this.scene = new Scene("canvas", "#000000");
      this.ball = new Circle(10, "#ffffff");
      this.ball.angle = 0;
      this.scene.on("tick", this.on_tick);
      this.scene.add(this.ball);
      return new Path(this.ball);
    };

    CircularMotion.prototype.on_tick = function() {
      this.ball.x = this.center_x + Math.cos(this.ball.angle) * this.path_radius;
      this.ball.y = this.center_y + Math.sin(this.ball.angle) * this.path_radius;
      this.path_radius += 0.1;
      return this.ball.angle += 0.1;
    };

    CircularMotion.prototype.on_resize = function() {
      this.center_x = this.window.width() / 2;
      this.center_y = this.window.height() / 2;
      this.canvas.attr("width", this.window.width());
      return this.canvas.attr("height", this.window.height());
    };

    return CircularMotion;

  })(AppView);
});
/*
//@ sourceMappingURL=circular_motion.map
*/