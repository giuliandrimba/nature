/*
  Compiled by Polvo, using CoffeeScript
*/

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

define('theoricus/mvc/view', ['require', 'exports', 'module', 'theoricus/mvc/model'], function(require, exports, module) {
  /**
    MVC module
    @module mvc
  */

  var Factory, Model, View;
  Model = require('theoricus/mvc/model');
  Factory = null;
  /**
    The View class is responsible for manipulating the templates (DOM).
  
    @class View
  */

  return module.exports = View = (function() {
    function View() {
      this.set_triggers = __bind(this.set_triggers, this);
      this._on_resize = __bind(this._on_resize, this);
      this._render = __bind(this._render, this);
    }

    /**
      Sets the title of the document.
      
      @property title {String}
    */


    View.prototype.title = null;

    /**
      Stores template's html as jQuery object.
      
      @property el {Object}
    */


    View.prototype.el = null;

    /**
     File's path relative to the app's folder.
      
     @property classpath {String}
    */


    View.prototype.classpath = null;

    /**
      Stores the class name
      
      @property classname {String}
    */


    View.prototype.classname = null;

    /**
      Namespace is the folder path relative to the `views` folder.
      
      @property namespace {String}
    */


    View.prototype.namespace = null;

    /**
      {{#crossLink "Process"}}{{/crossLink}} responsible for running the controller's action that rendered this view.
      
      @property process {Process}
    */


    View.prototype.process = null;

    /**
      Object responsible for binding the DOM events on the view. Use the format `selector event: handler` to define an event. It is called after the `template` was rendered in the document.
      
      @property events {Object}
      @example
          events:  
              ".bt-alert click":"on_alert"
    */


    View.prototype.events = null;

    /**
      Responsible for storing the template's data and the URL params.
      
      @property data {Object}
    */


    View.prototype.data = null;

    /**
      This function is executed by the Factory. It saves a `@the.factory` reference inside the view.
      
      @method _boot
      @param @the {Theoricus} Shortcut for app's instance
    */


    View.prototype._boot = function(the) {
      this.the = the;
      Factory = this.the.factory;
      return this;
    };

    /**
      Responsible for rendering the view, passing the data to the `template`.
      
      @method _render
      @param data {Object} Data object to be passed to the template, usually it is and instance of the {{#crossLink "Model"}}{{/crossLink}}
      @param [template=null] {String} The path of the template to be rendered.
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

    /**
      If there is a `before_render` method implemented, it will be executed before the view's template is appended to the document.
      
      @method before_render
      @param data {Object} Reference to the `@data`
    */


    /**
      Responsible for loading the given template, and appending it to view's `el` element.
      
      @method render_template
      @param template {String} Path to the template to be rendered.
    */


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

    /**
      If there is an `after_render` method implemented, it will be executed after the view's template is appended to the document. 
      
      Useful for caching DOM elements as jQuery objects.
      
      @method after_render
      @param data {Object} Reference to the `@data`
    */


    /**
      If there is an `@on_resize` method implemented, it will be executed whenever the window triggers the `scroll` event.
      
      @method on_resize
    */


    View.prototype._on_resize = function() {
      return typeof this.on_resize === "function" ? this.on_resize() : void 0;
    };

    /**
      Process the `@events`, automatically binding them.
      
      @method set_triggers
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

    /**
      If there is a `@before_in` method implemented, it will be called before the view execute its intro animations. 
      
      Useful to setting up the DOM elements properties before animating them.
      
      @method before_in
    */


    /**
      The `in` method is where the view intro animations are defined. It is executed after the `@after_render` method.
      
      The `@after_in` method must be called at the end of the animations, so Theoricus knows that the View finished animating.
      
      @method in
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

    /**
      If there is an`@after_in` method implemented, it will be called after the view finish its intro animations.
      
      Will only be executed if the {{#crossLink "Config"}}{{/crossLink}} property `disable_transitions` is `false`.
      
      @method after_in
    */


    /**
      If there is an`@before_out` method implemented, it will be called before the view executes its exit animations.
      
      @method before_out
    */


    /**
      The `@out` method is responsible for the view's exit animations. 
      
      At the end of the animations, the `after_out` callback must be called.
      
      @method out
      @param after_out {Function} Callback to be called when the animation ends.
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

    /**
      If there is an`@before_destroy` method implemented, it will be called before removing the view's template from the document.
      
      @method before_destroy
    */


    /**
      Destroy the view after executing the `@out` method, the default behaviour empties its `el` element and unbind the `window.resize` event.
      
      If overwritten, the `super` method must be called.
      
      Useful for removing variables assignments that needs to be removed from memory by the Garbage Collector, avoiding Memory Leaks.
      
      @method destroy
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

    /**
      Shortcut for application navigate.
      
      Navigate to the given URL.
      
      @method navigate
      @param url {String} URL to navigate to.
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