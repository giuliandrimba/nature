###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  module.exports = class Routes
  
    # all routes
    @routes =
  
      # main route
      '/pages':
        to: "pages/index"
        at: null
        el: "body"
  
      '/circles':
        to: "pages/circles"
        at: "/pages"
        el: "#container"
  
      '/404':
        to: "pages/notfound"
        at: "/pages"
        el: "#container"
  
    # default route
    @root = '/pages'
  
    # not found route
    @notfound = '/404'