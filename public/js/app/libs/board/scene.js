/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/libs/board/scene', ['require', 'exports', 'module', 'app/libs/board/utils/calc', 'app/libs/board/utils/microevent'], function(require, exports, module) {
  var Calc, MicroEvent, Scene;
  MicroEvent = require('app/libs/board/utils/microevent');
  Calc = require('app/libs/board/utils/calc');
  return module.exports = Scene = (function(_super) {
    __extends(Scene, _super);

    Scene.prototype.context = null;

    Scene.prototype.canvas = null;

    Scene.prototype.elements = [];

    Scene.prototype.background_color = null;

    function Scene(canvas_id, background_color) {
      var _this = this;
      this.background_color = background_color;
      this.destroy = __bind(this.destroy, this);
      this.update = __bind(this.update, this);
      this.tick = __bind(this.tick, this);
      this.stats = new Stats;
      this.stats.setMode(0);
      this.stats.domElement.style.position = 'absolute';
      this.stats.domElement.style.left = '0px';
      this.stats.domElement.style.top = '0px';
      document.body.appendChild(this.stats.domElement);
      setInterval((function() {
        _this.stats.begin();
        return _this.stats.end();
      }), 1000 / 60);
      this.canvas = document.getElementById(canvas_id);
      this.context = this.canvas.getContext("2d");
      this.ticker = window.requestAnimationFrame(this.tick);
    }

    Scene.prototype.tick = function() {
      this.emit("tick");
      this.update();
      return window.requestAnimationFrame(this.tick);
    };

    Scene.prototype.update = function() {
      var element, _i, _len, _ref, _results;
      this.emit("update");
      this.context.fillStyle = this.background_color;
      this.context.fillRect(0, 0, this.canvas.width, this.canvas.height);
      _ref = this.elements;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        element = _ref[_i];
        _results.push(element.draw());
      }
      return _results;
    };

    Scene.prototype.add = function(element) {
      this.elements.push(this.at(element));
      element.context = this.context;
      element.canvas = this.canvas;
      return element.scene = this;
    };

    Scene.prototype.destroy = function(element) {
      var i, item, _i, _len, _ref, _results;
      _ref = this.elements;
      _results = [];
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        item = _ref[i];
        if (item === element) {
          _results.push(this.elements.slice(i, 0));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Scene.prototype.at = function(element) {
      var ball, pos_ok, _i, _len, _ref;
      if (element.x || element.y || !this.elements.length) {
        return element;
      }
      element.x = Math.random() * this.canvas.width;
      element.y = Math.random() * this.canvas.height;
      pos_ok = false;
      while (pos_ok === false) {
        _ref = this.elements;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          ball = _ref[_i];
          if (!this.hit_circle(element, ball)) {
            pos_ok = true;
          }
        }
      }
      return element;
    };

    Scene.prototype.hit_circle = function(el0, el1) {
      var dist, dx, dy;
      dx = el1.x - el0.x;
      dy = el1.y - el0.y;
      dist = dx * dx + dy * dy;
      if (dist <= (el0.radius + el1.radius) * (el0.radius + el1.radius)) {
        return true;
      }
      return false;
    };

    return Scene;

  })(MicroEvent);
});
/*
//@ sourceMappingURL=scene.map
*/