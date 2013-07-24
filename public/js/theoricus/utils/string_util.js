/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/utils/string_util', ['require', 'exports', 'module'], function(require, exports, module) {
  var StringUtil;
  return module.exports = StringUtil = (function() {
    /*
    @param [String] str
    */

    function StringUtil() {}

    StringUtil.ucfirst = function(str) {
      var a, b;
      a = str.substr(0, 1).toUpperCase();
      b = str.substr(1);
      return a + b;
    };

    /*
    @param [String] str
    */


    StringUtil.camelize = function(str) {
      var buffer, part, parts, _i, _len;
      parts = [].concat(str.split("_"));
      buffer = "";
      for (_i = 0, _len = parts.length; _i < _len; _i++) {
        part = parts[_i];
        buffer += StringUtil.ucfirst(part);
      }
      return buffer;
    };

    /*
    @param [String] str
    */


    StringUtil.underscore = function(str) {
      str = str.replace(/([A-Z])/g, "_$1").toLowerCase();
      return str = str.substr(1) === "_" ? str.substr(1) : str;
    };

    return StringUtil;

  })();
});
/*
//@ sourceMappingURL=string_util.map
*/