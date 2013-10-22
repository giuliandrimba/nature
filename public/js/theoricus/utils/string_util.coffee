###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###*
    utils module
    @module utils
  ###
  
  ###*
    StringUtil class.
    @class StringUtil
  ###
  module.exports = class StringUtil
  
    ###*
  
    Capitalize first letter of the given string
    
    @method ucfirst
    @static
    @param str {String}
    @example
      StringUtil.ucfirst "theoricus" #returns 'Theoricus'
    ###
    @ucfirst=( str )->
      a = str.substr( 0, 1 ).toUpperCase()
      b = str.substr( 1 )
      return a + b
  
    ###*
    
    Convert String to CamelCase pattern.
    
    @method camelize
    @static
    @param str {String}
    @example
      StringUtil.camelize "giddy_up" #returns 'GiddyUp'
    ###
    @camelize=( str )->
      parts = [].concat( str.split "_" )
      buffer = ""
      buffer += StringUtil.ucfirst part for part in parts
      # some weirdness happening if we don't return the buffer
      return buffer
  
    ###*
  
    Split CamelCase words using underscore.
    
    @method underscore
    @static
    @param str {String}
    @example
      StringUtil.underscore "GiddyUp" #returns '_giddy_up'
    ###
    @underscore=( str )->
      str = str.replace( /([A-Z])/g, "_$1" ).toLowerCase()
      str = if str.substr( 1 ) == "_" then str.substr 1 else str