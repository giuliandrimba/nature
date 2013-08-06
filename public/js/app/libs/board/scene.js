/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define('app/libs/board/scene', ['require', 'exports', 'module', 'app/libs/board/utils/microevent'], function(require, exports, module) {
  var MicroEvent, Scene;
  MicroEvent = require('app/libs/board/utils/microevent');
  return module.exports = Scene = (function(_super) {
    __extends(Scene, _super);

    Scene.prototype.context = null;

    Scene.prototype.canvas = null;

    Scene.prototype.elements = [];

    Scene.prototype.background_color = null;

    function Scene(canvas_id, background_color) {
      this.background_color = background_color;
      this.destroy = __bind(this.destroy, this);
      this.update = __bind(this.update, this);
      this.tick = __bind(this.tick, this);
      this.canvas = document.getElementById(canvas_id);
      this.context = this.canvas.getContext("2d");
      this.ticker = window.requestAnimationFrame(this.tick);
      this.update();
    }

    Scene.prototype.tick = function() {
      this.emit("tick");
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
      this.elements.push(element);
      element.context = this.context;
      element.canvas = this.canvas;
      element.scene = this;
      return element.draw();
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

    return Scene;

  })(MicroEvent);
});
/*
//@ sourceMappingURL=scene.map
*/