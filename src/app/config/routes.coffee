module.exports = class Routes

  # all routes
  @routes =

    # main route
    '/pages':
      to: "pages/container"
      at: null
      el: "body"

    '/404':
      to: "pages/notfound"
      at: "/pages"
      el: "#container"

    '/pages/index':
      to: "pages/index"
      at: "/pages"
      el: "#container"

  # default route
  @root = '/pages/index'

  # not found route
  @notfound = '/404'