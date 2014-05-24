Particle = require "./particle"
Calc = require "draw/math/calc"
Draw = require "draw/draw"
Pivot = require "./pivot"

module.exports = class System

  NUM_PARTICLES: 50
  particles: []
  angle_step: 0
  angle: 0

  origin: {}
  pivot: {}
  mag: 1

  constructor:(@origin)->

    @angle_step = 360 / @NUM_PARTICLES
    @mouse = @origin.mouse
    @pivot = new Pivot @origin.follows
    @pivot.spring = 0.3
    @pivot.rotate = false
    @pivot.speed = 0.7

  setup:->
    @_create_particles()

  run:->

    @pivot.update()
    @pivot.draw()

    i = @particles.length - 1

    while i >= 0

      p = @particles[i]

      p.update()

      p.draw()

      i--

  _create_particles:->

    @particles = []

    fx = 0
    fy = 0

    i = 0

    while i < @NUM_PARTICLES

      @angle += @angle_step

      rad = Calc.deg2rad @angle

      mag = @origin.rad

      fx = (Math.cos rad) * mag
      fy = (Math.sin rad) * mag

      p = new Particle @pivot, fx, fy
      p.mag = @mag

      @particles.push p

      i++



