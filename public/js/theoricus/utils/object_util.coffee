###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    utils module
    @module utils
  ###
  
  ###*
    ObjectUtil class.
    @class ObjectUtil
  ###
  module.exports = class ObjectUtil
  
    ###*
  
    Check if source object has given `search` properties.
    
    @method find
    @static
    @param src {Object} Source object.
    @param search {Object} Object to be found within the source object.
    @param [strong_typing=false] {Boolean}
    @example
      obj = {name:"Drimba", age:22, skills:{language:"coffeescript", editor:"sublime"}}
      ObjectUtil.find obj, {age:22} #returns {name:"Drimba", age:22, skills:{language:"coffeescript", editor:"sublime"}}
    ###
    @find:( src, search, strong_typing = false )->
  
      for k, v of search
  
        if v instanceof Object
          return ObjectUtil.find src[k], v
  
        else if strong_typing
          return src if src[k] == v
  
        else
          return src if "#{src[k]}" is "#{v}"
      return null