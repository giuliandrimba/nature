module.exports = class Routes

  # all routes
  @routes =

    # main route
    '/pages':
      to: "pages/index"
      at: null
      el: "body"

    '/fractal':
      lab:true
      to: "fractal/index"
      at: "/pages"
      el: "#container"

    '/automata':
      lab:true
      to: "automata/index"
      at: "/pages"
      el: "#container"

    '/agents':
      lab:true
      to: "agents/index"
      at: "/pages"
      el: "#container"

    '/strings':
      lab:true
      to: "strings/index"
      at: "/pages"
      el: "#container"

    '/hole':
      lab:true
      to: "hole/index"
      at: "/pages"
      el: "#container"

    '/magnets':
      lab:true
      to: "magnets/index"
      at: "/pages"
      el: "#container"

    '/attract':
      lab:true
      to: "attract/index"
      at: "/pages"
      el: "#container"

    '/repulse':
      lab:true
      to: "repulse/index"
      at: "/pages"
      el: "#container"

    '/404':
      to: "pages/notfound"
      at: "/pages"
      el: "#container"

  # default route
  @root = '/automata'

  # not found route
  @notfound = '/404'
