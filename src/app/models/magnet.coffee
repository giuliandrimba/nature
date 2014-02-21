AppModel = require 'app/models/app_model'

module.exports = class Magnet extends AppModel

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
  #   'all'    : ['GET', '/magnets.json']
  #   'create' : ['POST','/magnets.json']
  #   'read'   : ['GET', '/magnets/:id.json']
  #   'update' : ['PUT', '/magnets/:id.json']
  #   'delete' : ['DELETE', '/magnets/:id.json']