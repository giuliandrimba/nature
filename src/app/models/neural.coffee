AppModel = require 'app/models/app_model'

module.exports = class Neural extends AppModel

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
  #   'all'    : ['GET', '/fractals.json']
  #   'create' : ['POST','/fractals.json']
  #   'read'   : ['GET', '/fractals/:id.json']
  #   'update' : ['PUT', '/fractals/:id.json']
  #   'delete' : ['DELETE', '/fractals/:id.json']
