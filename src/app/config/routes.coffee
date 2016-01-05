module.exports = class Routes

  # all routes
  @routes =

    # main route
    '/pages':
      to: "pages/index"
      at: null
      el: "body"

    '/neural-noise':
      index:9
      to: "neural/index"
      color: "#000"
      at: "/pages"
      el: "#container"

    '/evolution-of-form':
      index:8
      to: "ga/index"
      color: "#000"
      at: "/pages"
      el: "#container"

    '/chaotic-shapes':
      index:7
      to: "fractal/index"
      color: "#ccc"
      at: "/pages"
      el: "#container"

    '/game-of-life':
      index:6
      to: "automata/index"
      color: "#000"
      at: "/pages"
      el: "#container"

    '/walkers':
      index:5
      to: "agents/index"
      at: "/pages"
      el: "#container"

    '/springs-and-dots':
      index:4
      to: "strings/index"
      at: "/pages"
      el: "#container"

    '/spiral-hypnosis':
      index:3
      to: "hole/index"
      at: "/pages"
      el: "#container"

    '/invisible-force':
      index:2
      to: "magnets/index"
      at: "/pages"
      el: "#container"

    '/black-hole':
      index:1
      to: "attract/index"
      at: "/pages"
      el: "#container"

    '/opposite-forces':
      index:0
      to: "repulse/index"
      at: "/pages"
      el: "#container"

    '/info':
      to: "info/index"
      at: "/pages"
      el: "#container"

    '/404':
      to: "pages/notfound"
      at: "/pages"
      el: "#container"


  if /lab/.test(window.location.href)
    @routes =

      # main route
      '/pages':
        to: "pages/index"
        at: null
        el: "body"

      '/neural-noise':
        index:9
        to: "neural/index"
        color: "#000"
        at: "/pages"
        el: "#container"

      '/ga':
        index:8
        to: "ga/index"
        color: "#000"
        at: "/pages"
        el: "#container"

      '/fractal':
        index:7
        to: "fractal/index"
        color: "#ccc"
        at: "/pages"
        el: "#container"

      '/automata':
        index:6
        to: "automata/index"
        color: "#000"
        at: "/pages"
        el: "#container"

      '/agents':
        index:5
        to: "agents/index"
        at: "/pages"
        el: "#container"

      '/strings':
        index:4
        to: "strings/index"
        at: "/pages"
        el: "#container"

      '/hole':
        index:3
        to: "hole/index"
        at: "/pages"
        el: "#container"

      '/magnets':
        index:2
        to: "magnets/index"
        at: "/pages"
        el: "#container"

      '/attract':
        index:1
        to: "attract/index"
        at: "/pages"
        el: "#container"

      '/repulse':
        index:0
        to: "repulse/index"
        at: "/pages"
        el: "#container"

      '/info':
        to: "info/index"
        at: "/pages"
        el: "#container"

      '/404':
        to: "pages/notfound"
        at: "/pages"
        el: "#container"

  # default route
  if /lab/.test(window.location.href)
    @root = '/repulse'
  else
    @root = '/opposite-forces'

  # not found route
  @notfound = '/'

  @get_route_id = (id)->
    for p of @routes
      if @routes[p].index is id
        return p

  @get_prev = (route)->
    i = @routes[route].index
    if i > 0
      id = @get_route_id i-1
    else
      id = @get_route_id 9
    return id

  @get_next = (route)->
    i = @routes[route].index
    if i < 9
      id = @get_route_id i+1
      console.log id,i
    else
      id = @get_route_id 0
    return id

  @active_page = ()=>

    page = window.location.href.toString().split("/").pop()

    unless page.length

      page = @root.substring(1)

    return page



