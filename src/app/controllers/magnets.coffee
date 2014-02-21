AppController = require 'app/controllers/app_controller'
Magnet = require 'app/models/magnet'

module.exports = class Magnets extends AppController

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    DEFAULT ACTION BEHAVIOR
    Override it to take control and customize as you wish
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # <action-name>:()->
  #   if Magnet.all?
  #     @render "magnets/<action-name>", Magnet.all()
  #   else
  #     @render "magnets/<action-name>", null

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    EXAMPLES
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # list:()->
  #   @render "magnets/list", Magnet.all()

  # create:()->
  #   @render "magnets/create", null