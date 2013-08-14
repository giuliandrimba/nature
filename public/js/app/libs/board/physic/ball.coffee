###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  Circle = require 'app/libs/board/geometry/circle'
  
  module.exports = class Ball extends Circle