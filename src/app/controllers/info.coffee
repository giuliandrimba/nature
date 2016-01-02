AppController = require 'app/controllers/app_controller'
Info = require 'app/models/info'

module.exports = class Info extends AppController

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    DEFAULT ACTION BEHAVIOR
    Override it to take control and customize as you wish
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # <action-name>:()->
  #   if Fractal.all?
  #     @render "fractal/<action-name>", Fractal.all()
  #   else
  #     @render "fractal/<action-name>", null

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    EXAMPLES
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # list:()->
  #   @render "fractal/list", Fractal.all()

  # create:()->
  #   @render "fractal/create", null
