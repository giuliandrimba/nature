module.exports = class Vector

  @new:->

    v =
      x: 0
      y: 0

  @normalize:(vec)->

    m = @mag(vec)

    if m != 0 && m != 1
      return @div vec, m

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
      x: vec1.x + vec2.x
      y: vec1.y + vec2.y

  @sub:(vec1, vec2)->

    v =
      x: vec1.x - vec2.x
      y: vec1.y - vec2.y

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
    dy = vec1.y - vec2.y

    Math.sqrt dx * dx + dy * dy

  @dot:(vec1, vec2)->

    vec1.x * vec2.x + vec1.y * vec2.y

  @limit:(vec1, max)->

    if @mag(vec1) > max

      vec1 = @normalize vec1
      return (@mult vec1, max)

    return vec1

  @angle_between:(vec1, vec2)->

    if vec1.x is 0 and vec1.y is 0
      return 0

    if vec2.x is 0 and vec2.y is 0
      return 0

    dot = @dot vec1, vec2
    vec1_mag = @mag vec1
    vec2_mag = @mag vec2

    amt = dot / (vec1_mag * vec2_mag)

    if amt < -1
      return Math.PI
    else if amt > 1
      return 0

    return Math.acos(amt)








