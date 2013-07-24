/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('theoricus/mvc/view', ['require', 'exports', 'module', 'theoricus/mvc/model'], function(require, exports, module) {
  var Factory, Model, View;
  Model = require('theoricus/mvc/model');
  Factory = null;
  return module.exports = View = (function() {
    function View() {
      this.set_triggers = __bind(this.set_triggers, this);
      this._on_resize = __bind(this._on_resize, this);
      this._render = __bind(this._render, this);
    }

    View.prototype.title = null;

    View.prototype.el = null;

    View.prototype.classpath = null;

    View.prototype.classname = null;

    View.prototype.namespace = null;

    View.prototype.process = null;

    /*
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
    */


    View.prototype._boot = function(the) {
      this.the = the;
      Factory = this.the.factory;
      return this;
    };

    /*
    @param [Object] @data   Data to be passed to the template
    @param [Object] @el     Element where the view will be "attached/appended"
    */


    View.prototype._render = function(data, template) {
      var tmpl_folder, tmpl_name,
        _this = this;
      if (data == null) {
        data = {};
      }
      this.data = {
        view: this,
        params: this.process.params,
        data: data
      };
      if (typeof this.before_render === "function") {
        this.before_render(this.data);
      }
      this.process.on_activate = function() {
        if (typeof _this.on_activate === "function") {
          _this.on_activate();
        }
        if (_this.title != null) {
          return document.title = _this.title;
        }
      };
      this.el = $(this.process.route.el);
      if (template == null) {
        tmpl_folder = this.namespace.replace(/\./g, '/');
        tmpl_name = this.classname.underscore();
        template = "" + tmpl_folder + "/" + tmpl_name;
      }
      return this.render_template(template);
    };

    View.prototype.render_template = function(template) {
      var _this = this;
      return this.the.factory.template(template, function(template) {
        var dom;
        dom = template(_this.data);
        dom = _this.el.append(dom);
        if (_this.data instanceof Model) {
          _this.data.bind(dom, !_this.the.config.autobind);
        }
        if (typeof _this.set_triggers === "function") {
          _this.set_triggers();
        }
        if (typeof _this.after_render === "function") {
          _this.after_render(_this.data);
        }
        _this["in"]();
        if (_this.on_resize != null) {
          $(window).unbind('resize', _this._on_resize);
          $(window).bind('resize', _this._on_resize);
          return _this.on_resize();
        }
      });
    };

    View.prototype._on_resize = function() {
      return this.on_resize();
    };

    /*
    In case you defined @events in your view they will be automatically binded
    */


    View.prototype.set_triggers = function() {
      var all, ev, funk, sel, _ref, _ref1, _results;
      if (this.events == null) {
        return;
      }
      _ref = this.events;
      _results = [];
      for (sel in _ref) {
        funk = _ref[sel];
        _ref1 = sel.match(/(.*)[\s|\t]+([\S]+)$/m), all = _ref1[0], sel = _ref1[1], ev = _ref1[2];
        (this.el.find(sel)).unbind(ev, null, this[funk]);
        _results.push((this.el.find(sel)).bind(ev, null, this[funk]));
      }
      return _results;
    };

    /*
    Triggers view "animation in", "@after_in" must be called in the end
    */


    View.prototype["in"] = function() {
      var animate,
        _this = this;
      if (typeof this.before_in === "function") {
        this.before_in();
      }
      animate = this.the.config.enable_auto_transitions;
      animate &= !this.the.config.disable_transitions;
      if (!animate) {
        return typeof this.after_in === "function" ? this.after_in() : void 0;
      } else {
        this.el.css("opacity", 0);
        return this.el.animate({
          opacity: 1
        }, 300, function() {
          return typeof _this.after_in === "function" ? _this.after_in() : void 0;
        });
      }
    };

    /*
    Triggers view "animation out", "after_out" must be called in the end
     @param [Function] after_out Callback function to be triggered in the end
    */


    View.prototype.out = function(after_out) {
      var animate;
      if (typeof this.before_out === "function") {
        this.before_out();
      }
      animate = this.the.config.enable_auto_transitions;
      animate &= !this.the.config.disable_transitions;
      if (!animate) {
        return after_out();
      } else {
        return this.el.animate({
          opacity: 0
        }, 300, after_out);
      }
    };

    /*
    Destroy the view after the 'out' animation, the default behavior is to just
    empty it's container element.
      
    before_destroy will be called just before emptying it.
    */


    View.prototype.destroy = function() {
      if (this.on_resize != null) {
        $(window).unbind('resize', this._on_resize);
      }
      if (typeof this.before_destroy === "function") {
        this.before_destroy();
      }
      return this.el.empty();
    };

    /*
    Shortcut for application navigate
      
    @param [String] url URL to navigate
    */


    View.prototype.navigate = function(url) {
      return this.the.processes.router.navigate(url);
    };

    return View;

  })();
});
/*
//@ sourceMappingURL=view.map
*/