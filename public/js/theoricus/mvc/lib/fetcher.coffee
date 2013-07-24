###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  module.exports = class Fetcher
    loaded: null
  
    onload: null
    onerror: null
  
    data: null