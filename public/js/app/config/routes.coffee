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
  
      '/collisions':
        to: "pages/collisions"
        at: "/pages"
        el: "#container"
  
      '/circular_motion':
        to: "pages/circular_motion"
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