/*
  Compiled by Polvo, using CoffeeScript
*/

define('theoricus/utils/array_util', ['require', 'exports', 'module', 'theoricus/utils/object_util'], function(require, exports, module) {
  /**
    utils module
    @module utils
  */

  var ArrayUtil, ObjectUtil;
  ObjectUtil = require('theoricus/utils/object_util');
  /**
    ArrayUtil class.
    @class ArrayUtil
  */

  return module.exports = ArrayUtil = (function() {
    function ArrayUtil() {}

    /**
    
    Search for a record within the given source array that contains the `search` filter.
      
    @method find
    @static
    @param src {Array} Source array.
    @param search {Object} Object to be found within the source array.
    @example
      fruits = {name: "orange", id:0}, {name: "banana", id:1}, {name: "watermelon", id:2}
      ArrayUtil.find fruits, {name: "orange"} # returns {name: "orange", id:0}
    */


    ArrayUtil.find = function(src, search) {
      var i, v, _i, _len;
      for (i = _i = 0, _len = src.length; _i < _len; i = ++_i) {
        v = src[i];
        if (!(search instanceof Object)) {
          if (v === search) {
            return {
              item: v,
              index: i
            };
          }
        } else {
          if (ObjectUtil.find(v, search) != null) {
            return {
              item: v,
              index: i
            };
          }
        }
      }
      return null;
    };

    /**
      
    Delete a record within the given source array that contains the `search` filter.
      
    @method delete
    @static
    @param src {Array} Source array.
    @param search {Object} Object to be found within the source array.
    @example
      fruits = [{name: "orange", id:0}, {name: "banana", id:1}, {name: "watermelon", id:2}]
      ArrayUtil.delete fruits, {name: "banana"}
      console.log fruits #[{name: "orange", id:0}, {name: "watermelon", id:2}]
    */


    ArrayUtil["delete"] = function(src, search) {
      var item;
      item = ArrayUtil.find(src, search);
      if (item != null) {
        return src.splice(item.index, 1);
      }
    };

    return ArrayUtil;

  })();
});
/*
//@ sourceMappingURL=array_util.map
*/