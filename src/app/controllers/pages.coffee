AppController = require 'app/controllers/app_controller'
Page = require 'app/models/page'

module.exports = class Pages extends AppController

	constructor:()->

	collisions:()->
		@render "circles/collisions"

	circular_motion:()->
		@render "circles/circular_motion"
