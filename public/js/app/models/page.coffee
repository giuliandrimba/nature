###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  AppModel = require 'app/models/app_model'
  
  module.exports = class Page extends AppModel
  
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
    #   'all'    : ['GET', '/pages.json']
    #   'create' : ['POST','/pages.json']
    #   'read'   : ['GET', '/pages/:id.json']
    #   'update' : ['PUT', '/pages/:id.json']
    #   'delete' : ['DELETE', '/pages/:id.json']