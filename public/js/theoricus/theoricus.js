/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/theoricus', ['require', 'exports', 'module', 'theoricus/core/processes', 'theoricus/core/factory', 'theoricus/config/config', 'inflection', 'jquery', 'json'], function(require, exports, module) {
  var Config, Factory, Processes, Theoricus;
  Config = require('theoricus/config/config');
  Factory = require('theoricus/core/factory');
  Processes = require('theoricus/core/processes');
  require('inflection');
  require('jquery');
  require('json');
  return module.exports = Theoricus = (function() {
    Theoricus.prototype.app = null;

    Theoricus.prototype.base_path = '';

    Theoricus.prototype.root = null;

    Theoricus.prototype.factory = null;

    Theoricus.prototype.config = null;

    Theoricus.prototype.processes = null;

    Theoricus.prototype.crawler = (window.crawler = {
      is_rendered: false
    });

    function Theoricus(Settings, Routes) {
      this.Settings = Settings;
      this.Routes = Routes;
      this.config = new Config(this, this.Settings);
      this.factory = new Factory(this);
    }

    Theoricus.prototype.start = function() {
      return this.processes = new Processes(this, this.Routes);
    };

    return Theoricus;

  })();
});
/*
//@ sourceMappingURL=theoricus.map
*/