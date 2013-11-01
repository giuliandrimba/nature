Vector = require "./vector"
Draw = require("../draw")

module.exports = class Circle

  _radius:0
  _fill:"#ff0000"
  _stroke:"#000000"
  _pos:null

  constructor:(@_radius, @ctx)->

    @ctx = Draw.CTX unless @ctx
    @_pos = new Vector(0,0)

    Object.defineProperties @,
      "radius":
        get:()-> @_radius
        set:(val)-> @_radius = val

      "fill":
        get:()-> @_fill
        set:(val)-> @_fill = val

      "x":
        get:()-> @_pos.x
        set:(val)-> @_pos.x = val

      "y":
        get:()-> @_pos.y
        set:(val)-> @_pos.y = val

      "pos":
        get:()-> @_pos
        set:(val)-> @_pos = val

  draw:()->

    @ctx.fillStyle = @fill
    @ctx.beginPath()
    @ctx.arc @x, @y, @radius, 0, Math.PI*2,true
    @ctx.closePath()
    @ctx.fill()


