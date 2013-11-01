AppModel = require 'app/models/app_model'

module.exports = class Vector extends AppModel

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
  #   'all'    : ['GET', '/vectors.json']
  #   'create' : ['POST','/vectors.json']
  #   'read'   : ['GET', '/vectors/:id.json']
  #   'update' : ['PUT', '/vectors/:id.json']
  #   'delete' : ['DELETE', '/vectors/:id.json']