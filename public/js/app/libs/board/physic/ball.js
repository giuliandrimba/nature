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

    return Ball;

  })(Circle);
});
/*
//@ sourceMappingURL=ball.map
*/