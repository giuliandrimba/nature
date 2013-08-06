/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/libs/board/basic/circle', ['require', 'exports', 'module', 'app/libs/board/utils/microevent'], function(require, exports, module) {
  var Circle, MicroEvent;
  MicroEvent = require('app/libs/board/utils/microevent');
  return module.exports = Circle = (function(_super) {
    __extends(Circle, _super);

    Circle.prototype.angle = 10;

    Circle.prototype.speed = 5;

    Circle.prototype.path = [];

    Circle.prototype.counter = 0;

    Circle.prototype.mass = 0;

    Circle.prototype.next_x = 0;

    Circle.prototype.next_y = 0;

    Circle.prototype._radius = 0;

    Circle.prototype.color = "#000";

    Circle.prototype._x = 0;

    Circle.prototype._y = 0;

    function Circle(_radius, _color, _x, _y) {
      this._radius = _radius;
      this._color = _color;
      this._x = _x != null ? _x : 0;
      this._y = _y != null ? _y : 0;
      this.update = __bind(this.update, this);
      this.mass = this.radius;
      Object.defineProperties(this, {
        "x": {
          get: function() {
            return this._x;
          },
          set: function(value) {
            this._x = value;
            return this.scene.update();
          }
        },
        "y": {
          get: function() {
            return this._y;
          },
          set: function(value) {
            this._y = value;
            return this.scene.update();
          }
        },
        "radius": {
          get: function() {
            return this._radius;
          },
          set: function(value) {
            this._radius = value;
            return this.scene.update();
          }
        },
        "color": {
          get: function() {
            return this._color;
          },
          set: function(value) {
            this._color = value;
            return this.scene.update();
          }
        }
      });
    }

    Circle.prototype.draw = function() {
      this.context.fillStyle = this._color;
      this.context.beginPath();
      this.context.arc(this._x, this._y, this._radius, 0, Math.PI * 2, true);
      this.context.closePath();
      return this.context.fill();
    };

    Circle.prototype.update = function() {
      var radians;
      radians = this.angle * Math.PI / 180;
      this.vx = Math.cos(radians) * this.speed;
      this.vy = Math.sin(radians) * this.speed;
      this.next_x = this.x + this.vx;
      this.next_y = this.y + this.vy;
      return this.boundaries();
    };

    Circle.prototype.move = function() {
      this.x = this.next_x;
      return this.y = this.next_y;
    };

    Circle.prototype.destroy = function() {
      return console.log(this.scene({
        boundaries: function() {
          if (this.next_x >= (this.canvas.width - this.radius) || this.next_x < (0 + this.radius)) {
            this.angle = 180 - this.angle;
          }
          if (this.next_y >= (this.canvas.height - this.radius) || this.next_y < (0 + this.radius)) {
            return this.angle = 360 - this.angle;
          }
        }
      }));
    };

    return Circle;

  })(MicroEvent);
});
/*
//@ sourceMappingURL=circle.map
*/