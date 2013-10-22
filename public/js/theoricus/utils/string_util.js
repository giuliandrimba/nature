/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/utils/string_util', ['require', 'exports', 'module'], function(require, exports, module) {
  /**
    utils module
    @module utils
  */

  /**
    StringUtil class.
    @class StringUtil
  */

  var StringUtil;
  return module.exports = StringUtil = (function() {
    /**
      
    Capitalize first letter of the given string
    
    @method ucfirst
    @static
    @param str {String}
    @example
      StringUtil.ucfirst "theoricus" #returns 'Theoricus'
    */

    function StringUtil() {}

    StringUtil.ucfirst = function(str) {
      var a, b;
      a = str.substr(0, 1).toUpperCase();
      b = str.substr(1);
      return a + b;
    };

    /**
    
    Convert String to CamelCase pattern.
    
    @method camelize
    @static
    @param str {String}
    @example
      StringUtil.camelize "giddy_up" #returns 'GiddyUp'
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

    /**
      
    Split CamelCase words using underscore.
    
    @method underscore
    @static
    @param str {String}
    @example
      StringUtil.underscore "GiddyUp" #returns '_giddy_up'
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