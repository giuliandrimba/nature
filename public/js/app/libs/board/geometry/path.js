/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('app/libs/board/geometry/path', ['require', 'exports', 'module'], function(require, exports, module) {
  var Path;
  return module.exports = Path = (function() {
    Path.prototype.path = [];

    Path.prototype.counter = 0;

    function Path(element, color, thickness, interval) {
      this.element = element;
      this.color = color != null ? color : "#fff";
      this.thickness = thickness != null ? thickness : 1;
      this.interval = interval != null ? interval : 1;
      this.draw = __bind(this.draw, this);
      this.context = this.element.context;
      this.element.scene.on("update", this.draw);
    }

    Path.prototype.draw = function() {
      var i, point, _i, _len, _ref;
      if ((this.counter % this.interval) === 0) {
        this.path.push({
          x: this.element.x,
          y: this.element.y
        });
      }
      this.counter++;
      this.context.strokeStyle = this.color;
      this.context.lineWidth = this.thickness;
      this.context.beginPath();
      this.context.moveTo(this.path[0].x, this.path[0].y);
      _ref = this.path;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        point = _ref[i];
        this.context.lineTo(point.x, point.y);
      }
      this.context.stroke();
      return this.context.closePath();
    };

    return Path;

  })();
});
/*
//@ sourceMappingURL=path.map
*/