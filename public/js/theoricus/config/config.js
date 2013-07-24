/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/config/config', ['require', 'exports', 'module'], function(require, exports, module) {
  var Config;
  return module.exports = Config = (function() {
    Config.prototype.animate_at_startup = false;

    Config.prototype.enable_auto_transitions = true;

    Config.prototype.app_name = null;

    Config.prototype.no_push_state = null;

    Config.prototype.disable_transitions = null;

    /*
    @param [theoricus.Theoricus] @the   Shortcut for app's instance
    */


    function Config(the, Settings) {
      var _ref, _ref1, _ref2, _ref3;
      this.the = the;
      this.Settings = Settings;
      this.app_name = "app";
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