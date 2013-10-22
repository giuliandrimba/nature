###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    utils module
    @module utils
  ###
  
  ObjectUtil = require 'theoricus/utils/object_util'
  
  ###*
    ArrayUtil class.
    @class ArrayUtil
  ###
  module.exports = class ArrayUtil
    
    ###*
    
    Search for a record within the given source array that contains the `search` filter.
  
    @method find
    @static
    @param src {Array} Source array.
    @param search {Object} Object to be found within the source array.
    @example
      fruits = {name: "orange", id:0}, {name: "banana", id:1}, {name: "watermelon", id:2}
      ArrayUtil.find fruits, {name: "orange"} # returns {name: "orange", id:0}
    ###
    @find:( src, search )->
      for v, i in src
        unless (search instanceof Object)
          return item: v, index:i if v == search
        else
          return {item: v, index:i } if ObjectUtil.find(v, search)?
      return null
  
    ###*
  
    Delete a record within the given source array that contains the `search` filter.
  
    @method delete
    @static
    @param src {Array} Source array.
    @param search {Object} Object to be found within the source array.
    @example
      fruits = [{name: "orange", id:0}, {name: "banana", id:1}, {name: "watermelon", id:2}]
      ArrayUtil.delete fruits, {name: "banana"}
      console.log fruits #[{name: "orange", id:0}, {name: "watermelon", id:2}]
    ###
    @delete:( src, search )->
      item = ArrayUtil.find src, search
      src.splice item.index, 1 if item?