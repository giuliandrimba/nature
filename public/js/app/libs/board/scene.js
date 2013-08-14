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

    Scene.prototype.friction = 0;

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
      var element, _i, _len, _ref;
      this.context.fillStyle = this.background_color;
      this.context.fillRect(0, 0, this.canvas.width, this.canvas.height);
      this.collisions();
      _ref = this.elements;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        element = _ref[_i];
        element.draw();
      }
      return this.emit("update");
    };

    Scene.prototype.add = function(element) {
      this.elements.push(this.at(element));
      element.context = this.context;
      element.canvas = this.canvas;
      element.scene = this;
      return element.changed = true;
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
      if (element.x || element.y) {
        return element;
      }
      element._x = element.radius + (Math.random() * (window.innerWidth - element.radius));
      element._y = element.radius + (Math.random() * (window.innerHeight - element.radius));
      pos_ok = false;
      while (pos_ok === false) {
        if (this.elements.length === 0) {
          pos_ok = true;
          return element;
        }
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

    Scene.prototype.hit_circle = function(ball1, ball2) {
      var distance, dx, dy, retval;
      retval = false;
      dx = ball1.x - ball2.x;
      dy = ball1.y - ball2.y;
      distance = dx * dx + dy * dy;
      if (distance <= ((ball1.radius + ball2.radius) * (ball1.radius + ball2.radius))) {
        retval = true;
      }
      return retval;
    };

    Scene.prototype.collisions = function() {
      var circle, i, j, test_circle, _i, _j, _len, _len1, _ref, _ref1;
      _ref = this.elements;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        circle = _ref[i];
        if (circle.hit === false) {
          return;
        }
        _ref1 = this.elements;
        for (j = _j = 0, _len1 = _ref1.length; _j < _len1; j = ++_j) {
          test_circle = _ref1[j];
          if (circle.hit && test_circle.hit && circle !== test_circle) {
            if (this.hit_circle(circle, test_circle)) {
              this.collide(circle, test_circle);
            }
          }
        }
      }
    };

    Scene.prototype.collide = function(el0, el1) {
      var collisionAngle, direction1, direction2, dx, dy, final_vx_1, final_vx_2, final_vy_1, final_vy_2, speed1, speed2, vx_1, vx_2, vy_1, vy_2;
      dx = el0.x - el1.x;
      dy = el0.y - el1.y;
      collisionAngle = Math.atan2(dy, dx);
      speed1 = Math.sqrt(el0.vx * el0.vx + el0.vy * el0.vy);
      speed2 = Math.sqrt(el1.vx * el1.vx + el1.vy * el1.vy);
      direction1 = Math.atan2(el0.vy, el0.vx);
      direction2 = Math.atan2(el1.vy, el1.vx);
      vx_1 = speed1 * Math.cos(direction1 - collisionAngle);
      vy_1 = speed1 * Math.sin(direction1 - collisionAngle);
      vx_2 = speed2 * Math.cos(direction2 - collisionAngle);
      vy_2 = speed2 * Math.sin(direction2 - collisionAngle);
      final_vx_1 = ((el0.mass - el1.mass) * vx_1 + (el1.mass + el1.mass) * vx_2) / (el0.mass + el1.mass);
      final_vx_2 = ((el0.mass + el0.mass) * vx_1 + (el1.mass - el0.mass) * vx_2) / (el0.mass + el1.mass);
      final_vy_1 = vy_1;
      final_vy_2 = vy_2;
      el0.vx = Math.cos(collisionAngle) * final_vx_1 + Math.cos(collisionAngle + Math.PI / 2) * final_vy_1;
      el0.vy = Math.sin(collisionAngle) * final_vx_1 + Math.sin(collisionAngle + Math.PI / 2) * final_vy_1;
      el1.vx = Math.cos(collisionAngle) * final_vx_2 + Math.cos(collisionAngle + Math.PI / 2) * final_vy_2;
      el1.vy = Math.sin(collisionAngle) * final_vx_2 + Math.sin(collisionAngle + Math.PI / 2) * final_vy_2;
      el0.x = (el0.x += el0.vx);
      el0.y = (el0.y += el0.vy);
      el0.x = (el1.x += el1.vx);
      return el0.y = (el1.y += el1.vy);
    };

    return Scene;

  })(MicroEvent);
});
/*
//@ sourceMappingURL=scene.map
*/