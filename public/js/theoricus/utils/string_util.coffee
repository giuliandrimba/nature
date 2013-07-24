###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  module.exports = class StringUtil
  
    ###
    @param [String] str
    ###
    @ucfirst=( str )->
      a = str.substr( 0, 1 ).toUpperCase()
      b = str.substr( 1 )
      return a + b
  
    ###
    @param [String] str
    ###
    @camelize=( str )->
      parts = [].concat( str.split "_" )
      buffer = ""
      buffer += StringUtil.ucfirst part for part in parts
      # some weirdness happening if we don't return the buffer
      return buffer
  
    ###
    @param [String] str
    ###
    @underscore=( str )->
      str = str.replace( /([A-Z])/g, "_$1" ).toLowerCase()
      str = if str.substr( 1 ) == "_" then str.substr 1 else str