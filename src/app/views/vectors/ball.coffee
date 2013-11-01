Circle = require "draw/geom/circle"
Vector = require "draw/geom/vector"

module.exports = class Ball extends Circle

  pos:null
  vel:null
  acc:null
  mouse:null
  target:null
  iddle_target:null
  init_pos:null
  line_dir:null
  line_vel:null
  line_point:null

  topspeed:null

  constructor:()->

    super

    @x = Math.random() * @ctx.canvas.width
    @y = Math.random() * @ctx.canvas.height

    @init_pos = new Vector(@x,@y)
    @rnd_pos = Vector.rnd()
    @iddle_target = Vector.add(@pos, @rnd_pos)
    @vel = new Vector(0,0)
    @acc = Vector.rnd()
    @topspeed = 1
    @radius = 2

  update:(mouseX, mouseY)->

    @pos.add @acc

