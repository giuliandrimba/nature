AppView = require 'app/views/app_view'
Ball = require "./ball"
Magnet = require "./magnet"
Target = require "./target"
Draw = require "draw/draw"
Calc = require "draw/math/calc"

module.exports = class Index extends AppView

  magnets: []
  dragging: false
  started: true

  destroy:->
    @ctx.clear()
    @ctx.destroy()
    @ctx = null
    @magnets = []
    $("body").css "cursor":"default"
    super

  after_render:=>


    _ = @

    _.magnets = []

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

        Draw.CTX = $(".sketch").get(0).getContext("2d");

        _.ball = new Ball 20, "#000", "#fff", 4
        _.ball.x = 50
        _.ball.y = @height / 2

        i = 0

        while i < parseInt($(window).width() / 50)
        # while i < 1

          m = new Magnet 25 + (Math.random() * 35), "#FFF"
          m.x = Math.random() * @width
          m.y = 100 + (Math.random() * @height - 100)
          m.setup()
          _.magnets.push m
          i++


      is_mouse_over:(magnet)->

        if @mouse.x > (magnet.x - magnet.radius) and @mouse.x < (magnet.x + magnet.radius) and @mouse.y > (magnet.y - magnet.radius) and @mouse.y < (magnet.y + magnet.radius)
          return true

        return false

      update:->

        if $("body").css("cursor") is "move"
          $("body").css "cursor":"default"

        is_already_dragging = false

        for m in _.magnets
          if m.dragged
            is_already_dragging = true
            break

        for m in _.magnets
          m.update() 
          if _.started
            m.attract _.ball



          if @is_mouse_over(m) and _.dragging and !is_already_dragging
            m.dragged = true

          if m.dragged
            is_already_dragging = true
            m.x = @mouse.x
            m.y = @mouse.y

          if @is_mouse_over(m)
            $("body").css "cursor":"move"

        if _.started
          _.ball.update()

        # @check_collision()
        # @reached_target()

      check_collision:->

        for m in _.magnets

          dist = Calc.dist m.x, m.y, _.ball.x, _.ball.y

          if dist < (m.radius + _.ball.radius)
            _.ball.vx = 0
            _.ball.vy = 0

      reached_target:->

        dist = Calc.dist _.target.x, _.target.y, _.ball.x, _.ball.y

        if dist < _.target.radius
          _.target.mass = 500
          _.ball.vx *= 0.9
          _.ball.vy *= 0.9

        if dist < 2
          _.ball.vx = 0
          _.ball.vy = 0

      draw:->
        _.ball.draw()

        for m in _.magnets
          m.draw_lines_to _.ball
          m.draw() 

      mousedown:->

        _.dragging = true

      mouseup:->

        _.dragging = false
        $(document.body).css "cursor":"default"
        for m in _.magnets  
          m.setup()
          m.dragged = false

