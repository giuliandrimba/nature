/*
  Compiled by Polvo, using CoffeeScript
*/

define('app/libs/board/utils/microevent', ['require', 'exports', 'module'], function(require, exports, module) {
  /*
  Port of MicroEvent in Coffeescript with some naming modifications
  and a new 'once' method.
  
  Original project:
  https://github.com/jeromeetienne/microevent.js
  */

  var MicroEvent;
  return MicroEvent = (function() {
    function MicroEvent() {}

    MicroEvent.prototype._init = function() {
      return this._listn || (this._listn = {});
    };

    MicroEvent.prototype._create = function(e) {
      return this._init()[e] || (this._init()[e] = []);
    };

    MicroEvent.prototype.on = function(e, f) {
      return (this._create(e)).push(f);
    };

    MicroEvent.prototype.off = function(e, f) {
      var t;
      if ((t = this._init()[e]) != null) {
        return t.splice(t.indexOf(f), 1);
      }
    };

    MicroEvent.prototype.once = function(e, f) {
      var t,
        _this = this;
      return this.on(e, (t = function() {
        return (_this.off(e, t)) && f.apply(_this, arguments);
      }));
    };

    MicroEvent.prototype.emit = function(e) {
      var l, t, _i, _len;
      if ((t = this._init()[e]) != null) {
        for (_i = 0, _len = t.length; _i < _len; _i++) {
          l = t[_i];
          l.apply(this, [].slice(1));
        }
      }
      return 0;
    };

    MicroEvent.mixin = function(t) {
      var p;
      for (p in this.prototype) {
        t.prototype[p] = this.prototype[p];
      }
      return 0;
    };

    return MicroEvent;

  })();
});
/*
//@ sourceMappingURL=microevent.map
*/