###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		AppView = require 'app/views/app_view'
		Style = require 'styles/pages/index'
		Menu = require 'app/views/pages/menu'
		
		module.exports = class Index extends AppView
		
			title: "Codeman _Labs"
		
			before_render:()->
				@menu = new Menu
		
			constructor:()->
		