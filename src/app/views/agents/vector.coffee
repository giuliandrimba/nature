module.exports = class Vector

  @new:->

    v =
      x: 0
      y: 0

  @normalize:(vec)->

    m = @mag(vec)

    if m != 0 && m != 1
      return @div m

    vec

  @copy:(vec)->

    v =
      x: vec.x
      y: vec.y

  @mag:(vec)->

    Math.sqrt vec.x * vec.x + vec.y * vec.y

  @magSq:(vec)->

    vec.x * vec.x + vec.y * vec.y

  @add:(vec1, vec2)->

    v =
      x: vec1.x += vec2.x
      y: vec1.y += vec2.y

  @sub:(vec1, vec2)->

    v =
      x: vec1.x -= vec2.x
      y: vec1.y -= vec2.y

  @mult:(vec1, n)->

    v =
      x: vec1.x * n
      y: vec1.y * n

  @div:(vec1, n)->

    v =
      x: vec1.x / n
      y: vec1.y / n

  @dist:(vec1, vec2)->

    dx = vec1.x - vec2.x
    dx = vec1.y - vec2.y

    Math.sqrt dx * dx + dy * dy

  @dot:(vec1, vec2)->

    vec1.x * vec2.x + vec1.y * vec2.y

  @limit:(vec1, max)->

    if @maqSq(vec1) > max * max

      @normalize vec1
      @mult max







