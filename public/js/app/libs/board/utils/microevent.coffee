###
  Compiled by Polvo, using CoffeeScript
###

define ['require', 'exports', 'module'], (require, exports, module)->
  ###
  Port of MicroEvent in Coffeescript with some naming modifications
  and a new 'once' method.
  
  Original project:
  https://github.com/jeromeetienne/microevent.js
  ###
  class MicroEvent
  	_init:-> @_listn or @_listn = {}
  	_create:(e)-> @_init()[e] or  @_init()[e] = []
  	on:(e, f)-> (@_create e).push f
  	off:(e, f)-> (t.splice (t.indexOf f), 1) if (t = @_init()[e])?
  	once:(e, f)-> @on e, (t = => (@off e, t) && f.apply @, arguments)
  	emit:(e)-> l.apply @, ([].slice 1) for l in t if (t = @_init()[e])?; 0
  	@mixin=(t)-> t::[p] = @::[p] for p of @::; 0