###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ArrayUtil = require 'theoricus/utils/array_util'
  Binder = require 'theoricus/mvc/lib/binder'
  Fetcher = require 'theoricus/mvc/lib/fetcher'
  
  module.exports = class Model extends Binder
  
    @Factory     = null # will be defined on Factory constructor
    @_fields     = []
    @_collection = []
  
    # SETUP METHODS ############################################################
  
    @rest = ( host, resources ) ->
  
      [resources, host] = [host, null] unless resources?
  
      for k, v of resources
        @[k] = @_build_rest.apply @, [k].concat(v.concat host)
  
    @fields = ( fields, opts = validate: true ) ->
      @_build_gs key, type, opts for key, type of fields
  
  
  
    # # SETUP HELPERS ############################################################
  
    ###
    Builds a method to fetch the given service.
  
    Notice the method is being returned inside a private scope
    that contains all the variables needed to fetch the data.
  
    
    @param [String] key   
    @param [String] method  
    @param [String] url   
    @param [String] domain  
    ###
    @_build_rest = ( key, method, url, domain ) ->
      # console.log 'building ->', key, method, url, domain
  
      return call = ( args... ) ->
  
        if domain? && domain.substring( domain.length - 1 ) is "/"
          domain = domain.substring 0, domain.length - 1
  
        #console.log 'calling -->', key, method, url, domain, args
        
        # when asking to read a registry, check if it was already loaded
        # if so, return the cached entry
        if key is "read" and @_collection.length
          found = ArrayUtil.find @_collection, {id: args[0]}
          return found.item if found?
        
        # when calling a method, you can pass as last argument
        # one object that will be sent as data during the "ajax call"
        if args.length
          if (typeof args[args.length-1] is 'object')
            data = args.pop()
          else
            data = ''
  
        # creating a new variable for request url in order to do the replacing
        # logic from scratch every time the method is called
        # for some "weird" reason without this "hack" the url would 
        # build on top of the last built url, resulting in wrong addresses
        r_url = url
  
        # You can set variables on the URL using ":variable"
        # and they'll be replace by the args you pass.
        # 
        # i.e. 
        # @rest
        #     'all' : [ 'GET', 'my/path/to/:id.json' ]
        # 
        # called as MyModel.all( 66 )
        # will result in a call to "my/path/to/66.json"
        # 
        while (/:[a-z]+/.exec r_url)?
          r_url = url.replace /:[a-z]+/, args.shift() || null
  
        # if domain is specified we prepend to the url
        r_url = "#{domain}/#{r_url}" if domain?
  
        @_request method, r_url, data
  
  
  
    ###
    General request method
  
    @param [String] method  URL request method
    @param [String] url   URL to be requested
    @param [Object] data  Data to be send
    ###
    @_request = ( method, url, data='' ) ->
      # console.log "[Model] request", method, url, data
  
      fetcher = new Fetcher
  
      req = 
        url  : url
        type : method
        data : data
      
      # if url contains .json, sets dataType to json
      # this theoritically helps firefox ( and perhaps other browsers )
      # to deal with the request
      req.dataType = 'json' if /\.json/.test( url )
      
      req = $.ajax req
  
      req.done ( data )=>
        fetcher.loaded = true
        @_instantiate ([].concat data), (results)->
          fetcher.records = results
          fetcher.onload?( fetcher.records )
  
      req.error ( error )=>
        fetcher.error = true
        if fetcher.onerror?
          fetcher.onerror error
        else
            console.error error
  
      fetcher
  
  
  
    ###
    Builds local getters/setters for the given params
  
    @param [String] field
    @param [String] type
    ###
    @_build_gs = ( field, type, opts ) ->
      _val = null
  
      classname = ("#{@}".match /function\s(\w+)/)[1]
      stype = ("#{type}".match /function\s(\w+)/)[1]
      ltype = stype.toLowerCase()
  
      getter = -> _val
      setter = (value) ->
        switch ltype
          when 'string' then is_valid = (typeof value is 'string')
          when 'number' then is_valid = (typeof value is 'number')
          else is_valid = (value instanceof type)
  
        if is_valid or opts.validate is false
          _val = value
          @update field, _val
        else
          prop = "#{classname}.#{field}"
          msg = "Property '#{prop}' must to be #{stype}."
          throw new Error msg
  
      Object.defineProperty @::, field, get:getter, set:setter
  
  
  
    ###
    Instantiate one Model instance for each of the items present in data.
  
    And array with 10 items will result in 10 new models, that will be 
    cached into @_collection variable
  
    @param [Object] data  Data to be parsed
    ###
    @_instantiate = ( data, callback ) ->
  
      classname = ("#{@}".match /function\s(\w+)/)[1]
      records = []
  
      for record, at in data
  
        Model.Factory.model classname, record, (_model)=>
          records.push _model
  
          if records.length is data.length
  
            # When calling the rest service multiple times, the collection
            # variable keeps the old data and duplicate the recordset between a
            # rest call and another one. For now, just flush the old collection
            # when instantiate a new model instance
  
            @_collection = ( @_collection || [] ).concat records
  
            callback (if records.length is 1 then records[0] else records)
  
  