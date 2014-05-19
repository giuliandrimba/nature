Particle = require "./particle"
Calc = require "draw/math/calc"

module.exports = class System

  NUM_PARTICLES: 50
  particles: []
  angle_step: 0
  angle: 0

  step: 0

  origin: {}

  constructor:(@origin)->

    @angle_step = 360 / @NUM_PARTICLES
    @_create_particles()

  run:->

    i = @particles.length - 1

    while i >= 0

      p = @particles[i]

      @particles[@step]?.add_force()

      p.update()
      p.draw()

      if p.is_dead()

        @particles.splice i, 1

      i--

    @step++

    if @step >= @particles.length
      @step = 0

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

      @particles.push (new Particle @origin.x, @origin.y, fx, fy)

      i++



