/*
  Compiled by Polvo, using CoffeeScript
*/

var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __slice = [].slice;

define('theoricus/mvc/model', ['require', 'exports', 'module', 'theoricus/mvc/lib/fetcher', 'theoricus/mvc/lib/binder', 'theoricus/utils/array_util'], function(require, exports, module) {
  var ArrayUtil, Binder, Fetcher, Model, _ref;
  ArrayUtil = require('theoricus/utils/array_util');
  Binder = require('theoricus/mvc/lib/binder');
  Fetcher = require('theoricus/mvc/lib/fetcher');
  return module.exports = Model = (function(_super) {
    __extends(Model, _super);

    function Model() {
      _ref = Model.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Model.Factory = null;

    Model._fields = [];

    Model._collection = [];

    Model.rest = function(host, resources) {
      var k, v, _ref1, _results;
      if (resources == null) {
        _ref1 = [host, null], resources = _ref1[0], host = _ref1[1];
      }
      _results = [];
      for (k in resources) {
        v = resources[k];
        _results.push(this[k] = this._build_rest.apply(this, [k].concat(v.concat(host))));
      }
      return _results;
    };

    Model.fields = function(fields, opts) {
      var key, type, _results;
      if (opts == null) {
        opts = {
          validate: true
        };
      }
      _results = [];
      for (key in fields) {
        type = fields[key];
        _results.push(this._build_gs(key, type, opts));
      }
      return _results;
    };

    /*
    Builds a method to fetch the given service.
      
    Notice the method is being returned inside a private scope
    that contains all the variables needed to fetch the data.
      
    
    @param [String] key   
    @param [String] method  
    @param [String] url   
    @param [String] domain
    */


    Model._build_rest = function(key, method, url, domain) {
      var call;
      return call = function() {
        var args, data, found, r_url;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        if ((domain != null) && domain.substring(domain.length - 1) === "/") {
          domain = domain.substring(0, domain.length - 1);
        }
        if (key === "read" && this._collection.length) {
          found = ArrayUtil.find(this._collection, {
            id: args[0]
          });
          if (found != null) {
            return found.item;
          }
        }
        if (args.length) {
          if (typeof args[args.length - 1] === 'object') {
            data = args.pop();
          } else {
            data = '';
          }
        }
        r_url = url;
        while ((/:[a-z]+/.exec(r_url)) != null) {
          r_url = url.replace(/:[a-z]+/, args.shift() || null);
        }
        if (domain != null) {
          r_url = "" + domain + "/" + r_url;
        }
        return this._request(method, r_url, data);
      };
    };

    /*
    General request method
      
    @param [String] method  URL request method
    @param [String] url   URL to be requested
    @param [Object] data  Data to be send
    */


    Model._request = function(method, url, data) {
      var fetcher, req,
        _this = this;
      if (data == null) {
        data = '';
      }
      fetcher = new Fetcher;
      req = {
        url: url,
        type: method,
        data: data
      };
      if (/\.json/.test(url)) {
        req.dataType = 'json';
      }
      req = $.ajax(req);
      req.done(function(data) {
        fetcher.loaded = true;
        return _this._instantiate([].concat(data), function(results) {
          fetcher.records = results;
          return typeof fetcher.onload === "function" ? fetcher.onload(fetcher.records) : void 0;
        });
      });
      req.error(function(error) {
        fetcher.error = true;
        if (fetcher.onerror != null) {
          return fetcher.onerror(error);
        } else {
          return console.error(error);
        }
      });
      return fetcher;
    };

    /*
    Builds local getters/setters for the given params
      
    @param [String] field
    @param [String] type
    */


    Model._build_gs = function(field, type, opts) {
      var classname, getter, ltype, setter, stype, _val;
      _val = null;
      classname = (("" + this).match(/function\s(\w+)/))[1];
      stype = (("" + type).match(/function\s(\w+)/))[1];
      ltype = stype.toLowerCase();
      getter = function() {
        return _val;
      };
      setter = function(value) {
        var is_valid, msg, prop;
        switch (ltype) {
          case 'string':
            is_valid = typeof value === 'string';
            break;
          case 'number':
            is_valid = typeof value === 'number';
            break;
          default:
            is_valid = value instanceof type;
        }
        if (is_valid || opts.validate === false) {
          _val = value;
          return this.update(field, _val);
        } else {
          prop = "" + classname + "." + field;
          msg = "Property '" + prop + "' must to be " + stype + ".";
          throw new Error(msg);
        }
      };
      return Object.defineProperty(this.prototype, field, {
        get: getter,
        set: setter
      });
    };

    /*
    Instantiate one Model instance for each of the items present in data.
      
    And array with 10 items will result in 10 new models, that will be 
    cached into @_collection variable
      
    @param [Object] data  Data to be parsed
    */


    Model._instantiate = function(data, callback) {
      var at, classname, record, records, _i, _len, _results,
        _this = this;
      classname = (("" + this).match(/function\s(\w+)/))[1];
      records = [];
      _results = [];
      for (at = _i = 0, _len = data.length; _i < _len; at = ++_i) {
        record = data[at];
        _results.push(Model.Factory.model(classname, record, function(_model) {
          records.push(_model);
          if (records.length === data.length) {
            _this._collection = (_this._collection || []).concat(records);
            return callback((records.length === 1 ? records[0] : records));
          }
        }));
      }
      return _results;
    };

    return Model;

  })(Binder);
});
/*
//@ sourceMappingURL=model.map
*/