Particle = require "./particle"
Calc = require "draw/math/calc"
Draw = require "draw/draw"

module.exports = class System

  NUM_PARTICLES: 50
  particles: []
  angle_step: 0
  angle: 0

  origin: {}
  pivot: {}

  constructor:(@origin)->

    @angle_step = 360 / @NUM_PARTICLES
    @mouse = @origin.mouse
    @_create_particles()

  run:->

    i = @particles.length - 1

    while i >= 0

      p = @particles[i]

      p.update()

      p.draw()

      if p.is_dead()

        @particles.splice i, 1

      i--

  is_dead:->

    return !@particles.length

  _create_particles:->

    @particles = []

    fx = 0
    fy = 0

    i = 0

    while i < @NUM_PARTICLES

      @angle += @angle_step

      rad = Calc.deg2rad @angle

      fx = Math.cos rad
      fy = Math.sin rad

      p = new Particle @origin.x, @origin.y, fx, fy

      @particles.push p

      i++



