Calc = require "../math/calc"

module.exports = class Vector

  _x:0
  _y:0

  constructor:(@_x, @_y)->

    Object.defineProperties @,
      "x":
        get:()-> @_x
        set:(val)-> @_x = val

      "y":
        get:()-> @_y
        set:(val)-> @_y = val

  add:(vector)->
    @x += vector.x
    @y += vector.y

  @add:(v1,v2)-> new Vector (v1.x + v2.x),(v1.y + v1.y)

  sub:(vector)->
    @x -= vector.x
    @y -= vector.y

  @sub:(v1,v2)-> new Vector v1.x - v2.x,v1.y - v2.y

  mult:(n)->
    @x *= n
    @y *= n

  @mult:(n)-> new Vector @x * n,@y * n

  div:(n)->
    @x /= n
    @y /= n

  @div:(n)-> new Vector @x / n,@y / n

  mag:()->
    # Math.atan2 @x, @y

  norm:()->
    m = @mag()
    @div(m)

  limit:(n)->
    if @mag() > n
      @norm()
      @mult n

  @rnd:()-> new Vector Math.random(), Math.random()

