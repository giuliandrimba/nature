/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/config/config', ['require', 'exports', 'module'], function(require, exports, module) {
  /**
    Config module
    @module config
  */

  /**
    Config class.
    @class Config
  */

  var Config;
  return module.exports = Config = (function() {
    /**
      If true, execute all the animations at startup, or skip them and just render the views.
      
      @property {Boolean} animate_at_startup
    */

    Config.prototype.animate_at_startup = false;

    /**
      If true, insert automatically fadeIn/fadeOut transitions for the views.
      
      @property {Boolean} enable_auto_transitions
    */


    Config.prototype.enable_auto_transitions = true;

    /**
      If true, skip all the transitions, and just render the views.
      
      @property {Boolean} disable_transitions
    */


    Config.prototype.disable_transitions = null;

    /**
    Config constructor, initializing the app's config settings.
    @class Config
    @constructor
    @param the {Theoricus} Shortcut for app's instance
    @param Settings {Object} App settings
    */


    function Config(the, Settings) {
      var _ref, _ref1, _ref2, _ref3;
      this.the = the;
      this.Settings = Settings;
      this.disable_transitions = (_ref = this.Settings.disable_transitions) != null ? _ref : false;
      this.animate_at_startup = (_ref1 = this.Settings.animate_at_startup) != null ? _ref1 : true;
      this.enable_auto_transitions = (_ref2 = this.Settings.enable_auto_transitions) != null ? _ref2 : true;
      this.autobind = (_ref3 = this.Settings.autobind) != null ? _ref3 : false;
      this.vendors = this.Settings.vendors;
    }

    return Config;

  })();
});
/*
//@ sourceMappingURL=config.map
*/