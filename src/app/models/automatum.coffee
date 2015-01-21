AppModel = require 'app/models/app_model'

module.exports = class Automatum extends AppModel

  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    MODEL PROPERTIES
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # @fields
  #   'id'   : Number
  #   'name' : String
  #   'age'  : Number



  ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RESTFULL JSON SPECIFICATION
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

  # @rest
  #   'all'    : ['GET', '/automata.json']
  #   'create' : ['POST','/automata.json']
  #   'read'   : ['GET', '/automata/:id.json']
  #   'update' : ['PUT', '/automata/:id.json']
  #   'delete' : ['DELETE', '/automata/:id.json']