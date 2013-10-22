/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/utils/object_util', ['require', 'exports', 'module'], function(require, exports, module) {
  /**
    utils module
    @module utils
  */

  /**
    ObjectUtil class.
    @class ObjectUtil
  */

  var ObjectUtil;
  return module.exports = ObjectUtil = (function() {
    function ObjectUtil() {}

    /**
      
    Check if source object has given `search` properties.
    
    @method find
    @static
    @param src {Object} Source object.
    @param search {Object} Object to be found within the source object.
    @param [strong_typing=false] {Boolean}
    @example
      obj = {name:"Drimba", age:22, skills:{language:"coffeescript", editor:"sublime"}}
      ObjectUtil.find obj, {age:22} #returns {name:"Drimba", age:22, skills:{language:"coffeescript", editor:"sublime"}}
    */


    ObjectUtil.find = function(src, search, strong_typing) {
      var k, v;
      if (strong_typing == null) {
        strong_typing = false;
      }
      for (k in search) {
        v = search[k];
        if (v instanceof Object) {
          return ObjectUtil.find(src[k], v);
        } else if (strong_typing) {
          if (src[k] === v) {
            return src;
          }
        } else {
          if (("" + src[k]) === ("" + v)) {
            return src;
          }
        }
      }
      return null;
    };

    return ObjectUtil;

  })();
});
/*
//@ sourceMappingURL=object_util.map
*/