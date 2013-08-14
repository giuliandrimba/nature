/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/libs/board/physic/ball', ['require', 'exports', 'module', 'app/libs/board/geometry/circle'], function(require, exports, module) {
  var Ball, Circle, _ref;
  Circle = require('app/libs/board/geometry/circle');
  return module.exports = Ball = (function(_super) {
    __extends(Ball, _super);

    function Ball() {
      _ref = Ball.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Ball.prototype.hit = true;

    Ball.prototype.mass = 0;

    Ball.prototype.move = function() {
      this.vx = this.vx - (this.vx * this.scene.friction);
      this.vy = this.vy - (this.vy * this.scene.friction);
      this.next_x = this._x + this.vx;
      this.next_y = this._y + this.vy;
      this.bounds();
      this._x = this.next_x;
      this._y = this.next_y;
      return this.changed = true;
    };

    Ball.prototype.bounds = function() {
      if (this.next_x >= (this.canvas.width - this.radius) || this.next_x < (0 + this.radius)) {
        this.vx *= -1;
      }
      if (this.next_y >= (this.canvas.height - this.radius) || this.next_y < (0 + this.radius)) {
        return this.vy *= -1;
      }
    };

    return Ball;

  })(Circle);
});
/*
//@ sourceMappingURL=ball.map
*/