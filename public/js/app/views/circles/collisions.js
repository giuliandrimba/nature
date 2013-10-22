/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/views/circles/collisions', ['require', 'exports', 'module', 'app/libs/board/geometry/path', 'app/libs/board/physic/ball', 'app/libs/board/scene', 'app/views/app_view'], function(require, exports, module) {
  var AppView, Ball, Index, Path, Scene, _ref;
  AppView = require('app/views/app_view');
  Scene = require('app/libs/board/scene');
  Ball = require('app/libs/board/physic/ball');
  Path = require('app/libs/board/geometry/path');
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
      var ball, i, _results;
      this.window = $(window);
      this.canvas = $("#canvas");
      this.scene = new Scene("canvas", "#ff0000");
      this.scene.on("tick", this.on_tick);
      i = 0;
      _results = [];
      while (i < 10) {
        ball = new Ball(3 + (Math.random() * 9), "#fff");
        ball.speed = 4;
        ball.angle = Math.floor(Math.random() * 360);
        ball.hit = true;
        this.scene.add(ball);
        _results.push(i++);
      }
      return _results;
    };

    Index.prototype.on_tick = function() {
      var ball, _i, _len, _ref1, _results;
      _ref1 = this.scene.elements;
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        ball = _ref1[_i];
        _results.push(ball.move());
      }
      return _results;
    };

    Index.prototype.add_target = function(e) {
      this.mouse_x = e.pageX;
      this.mouse_y = e.pageY;
      this.target = new Ball(3 + (Math.random() * 9), "#ffffff", this.mouse_x, this.mouse_y);
      this.target.speed = 4;
      this.target.angle = Math.floor(Math.random() * 360);
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
//@ sourceMappingURL=collisions.map
*/