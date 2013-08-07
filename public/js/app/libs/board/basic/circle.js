/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/libs/board/basic/circle', ['require', 'exports', 'module', 'app/libs/board/utils/calc', 'app/libs/board/utils/microevent'], function(require, exports, module) {
  var Calc, Circle, MicroEvent;
  MicroEvent = require('app/libs/board/utils/microevent');
  Calc = require('app/libs/board/utils/calc');
  return module.exports = Circle = (function(_super) {
    __extends(Circle, _super);

    Circle.prototype._angle = 10;

    Circle.prototype._radians = 0;

    Circle.prototype.hit = false;

    Circle.prototype.speed = 5;

    Circle.prototype.path = [];

    Circle.prototype.counter = 0;

    Circle.prototype.mass = 0;

    Circle.prototype.next_x = 0;

    Circle.prototype.next_y = 0;

    Circle.prototype._radius = 0;

    Circle.prototype._color = "#000";

    Circle.prototype.x_vel = 0;

    Circle.prototype.y_vel = 0;

    Circle.prototype._x = 0;

    Circle.prototype._y = 0;

    function Circle(_radius, _color, _x, _y) {
      this._radius = _radius;
      this._color = _color;
      this._x = _x;
      this._y = _y;
      this.mass = this.radius;
      Object.defineProperties(this, {
        "x": {
          get: function() {
            return this._x;
          },
          set: function(value) {
            return this._x = value;
          }
        },
        "y": {
          get: function() {
            return this._y;
          },
          set: function(value) {
            return this._y = value;
          }
        },
        "radius": {
          get: function() {
            return this._radius;
          },
          set: function(value) {
            this._radius = value;
            return this.bounds();
          }
        },
        "color": {
          get: function() {
            return this._color;
          },
          set: function(value) {
            return this._color = value;
          }
        },
        "angle": {
          get: function() {
            return this._angle;
          },
          set: function(value) {
            this._angle = value;
            this._radians = Calc.ang2rad(this._angle);
            this.x_vel = Math.cos(this._radians) * this.speed;
            return this.y_vel = Math.sin(this._radians) * this.speed;
          }
        }
      });
    }

    Circle.prototype.forward = function() {
      this.x += this.x_vel;
      this.y += this.y_vel;
      return this.bounds();
    };

    Circle.prototype.draw = function() {
      this.context.fillStyle = this.color;
      this.context.beginPath();
      this.context.arc(this.x, this.y, this.radius, 0, Math.PI * 2, true);
      this.context.closePath();
      return this.context.fill();
    };

    Circle.prototype.bounds = function() {
      if (this.x >= (this.canvas.width - this.radius) || this.x < (0 + this.radius)) {
        this.angle = 180 - this.angle;
      }
      if (this.y >= (this.canvas.height - this.radius) || this.y < (0 + this.radius)) {
        return this.angle = 360 - this.angle;
      }
    };

    return Circle;

  })(MicroEvent);
});
/*
//@ sourceMappingURL=circle.map
*/