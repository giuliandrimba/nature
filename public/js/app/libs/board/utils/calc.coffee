###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		module.exports = class Calc
		
			@ang2rad:(angle)->
				angle * Math.PI / 180