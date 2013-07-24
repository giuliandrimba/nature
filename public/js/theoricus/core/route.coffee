###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  module.exports = class Route
  
    # static regex for reuse
    @named_param_reg: /:\w+/g
    @splat_param_reg: /\*\w+/g
  
    # regex matcher
    matcher: null
  
    # construct variables
    match: null
    to: null
    at: null
    el: null
  
    # api info
    controller_name: null
    action_name: null
    param_names: null
  
    constructor:( @match, @to, @at, @el )->
  
      # prepare regex matcher str for reuse
      @matcher = @match.replace Route.named_param_reg, '([^\/]+)'
      @matcher = @matcher.replace Route.splat_param_reg, '(.*?)'
      @matcher = new RegExp "^#{@matcher}$", 'm'
  
      # fitlers controller and action name
      [@controller_name, @action_name] = to.split '/'
  
  
    extract_params:( url )->
      # initialize empty params object
      params = {}
  
      # filters route's params names
      if (param_names = @match.match /(:|\*)\w+/g)?
        for value, index in param_names
          param_names[index] = value.substr 1
      else
        param_names = []
  
      # extract url params based on route
      params_values = (url.match @matcher)?.slice 1 or []
  
      # mounts params object with key->values pairs
      if params_values?
        for val, index in params_values
          key = param_names[ index ]
          params[key] = val
  
      return params
  
    rewrite_url_with_parms:( url, params )->
      for key, value of params
        reg = new RegExp "[:\\*]+#{key}", 'g'
        url = url.replace reg, value
      return url
  
    # test given url against the route
    test:( url )->
      @matcher.test url