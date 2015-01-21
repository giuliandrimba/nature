AppController = require 'app/controllers/app_controller'
Automatum = require 'app/models/automatum'

module.exports = class Automata extends AppController

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    DEFAULT ACTION BEHAVIOR
    Override it to take control and customize as you wish
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # <action-name>:()->
  #   if Automatum.all?
  #     @render "automata/<action-name>", Automatum.all()
  #   else
  #     @render "automata/<action-name>", null

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    EXAMPLES
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # list:()->
  #   @render "automata/list", Automatum.all()

  # create:()->
  #   @render "automata/create", null