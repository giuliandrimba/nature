###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
		AppController = require 'app/controllers/app_controller'
		Page = require 'app/models/page'
		
		module.exports = class Pages extends AppController
		
			### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				DEFAULT ACTION BEHAVIOR
				Override it to take control and customize as you wish
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
		
			# <action-name>:()->
			#   if Page.all?
			#     @render "pages/<action-name>", Page.all()
			#   else
			#     @render "pages/<action-name>", null
		
			### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				EXAMPLES
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
		
			# list:()->
			#   @render "pages/list", Page.all()
		
			# create:()->
			#   @render "pages/create", null
		
			collisions:()->
				@render "circles/collisions"
		
			circular_motion:()->
				@render "circles/circular_motion"