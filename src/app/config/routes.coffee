module.exports = class Routes

  # all routes
  @routes =

    # main route
    '/pages':
      to: "pages/index"
      at: null
      el: "body"

    '/vectors':
      to: "vectors/index"
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