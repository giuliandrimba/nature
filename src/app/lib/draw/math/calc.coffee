module.exports = class Calc

  @rnd2d:()->

    x = Math.random()
    y = Math.random()

    x:x,y:y

  @dist:(x1,y1,x2,y2)->
    dx = x1 - x2
    dy = y1 - y2
    Math.sqrt(dx * dx + dy * dy)

  @ang:(x1,y1,x2,y2)->
    angle = Math.atan2(y2 - y1, x2 - x1) * (180 / Math.PI);

  @deg2rad:(deg)->
    deg * Math.PI / 180

  @rad2deg:(rad)->
    rad * 180 / Math.PI

  @lerp:(start, stop, amt)->
    amt*(stop-start)+start;

  @map: (n, start1, stop1, start2, stop2)->
    ((n-start1)/(stop1-start1))*(stop2-start2)+start2


