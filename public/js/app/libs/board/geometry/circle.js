/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/libs/board/geometry/circle', ['require', 'exports', 'module', 'app/libs/board/utils/calc', 'app/libs/board/utils/microevent'], function(require, exports, module) {
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

    Circle.prototype.changed = false;

    function Circle(_radius, _color, next_x, next_y) {
      this._radius = _radius;
      this._color = _color;
      this.next_x = next_x;
      this.next_y = next_y;
      this.mass = this._radius;
      if (this.next_x) {
        this._x = this.next_x;
      }
      if (this.next_y) {
        this._y = this.next_y;
      }
      Object.defineProperties(this, {
        "x": {
          get: function() {
            return this.next_x;
          },
          set: function(value) {
            this.next_x = value;
            return this.changed = true;
          }
        },
        "y": {
          get: function() {
            return this.next_y;
          },
          set: function(value) {
            this.next_y = value;
            return this.changed = true;
          }
        },
        "radius": {
          get: function() {
            return this._radius;
          },
          set: function(value) {
            this._radius = value;
            return this.changed = true;
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
            this.y_vel = Math.sin(this._radians) * this.speed;
            return this.changed = true;
          }
        }
      });
    }

    Circle.prototype.forward = function() {
      this.x_vel = this.x_vel - (this.x_vel * this.scene.friction);
      this.y_vel = this.y_vel - (this.y_vel * this.scene.friction);
      this.next_x = this._x + this.x_vel;
      this.next_y = this._y + this.y_vel;
      this.bounds();
      this._x = this.next_x;
      this._y = this.next_y;
      return this.changed = true;
    };

    Circle.prototype.draw = function() {
      this.context.fillStyle = this.color;
      this.context.beginPath();
      this.context.arc(this._x, this._y, this.radius, 0, Math.PI * 2, true);
      this.context.closePath();
      this.context.fill();
      return this.changed = false;
    };

    Circle.prototype.bounds = function() {
      if (this.next_x >= (this.canvas.width - this.radius) || this.next_x < (0 + this.radius)) {
        this.x_vel *= -1;
      }
      if (this.next_y >= (this.canvas.height - this.radius) || this.next_y < (0 + this.radius)) {
        return this.y_vel *= -1;
      }
    };

    return Circle;

  })(MicroEvent);
});
/*
//@ sourceMappingURL=circle.map
*/