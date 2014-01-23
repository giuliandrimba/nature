AppView = require 'app/views/app_view'
PIXI = require "pixi"
Ball = require "./ball"

module.exports = class Index extends AppView

  after_render:()->

    console.log "after_render"

    @stage = new PIXI.Stage(0x111111)
    @renderer = PIXI.autoDetectRenderer $(window).width(), $(window).height(), null, false, true
    @renderer.view.style.display = "block";

    @el.get(0).appendChild @renderer.view
    window.requestAnimFrame @update

    @ball = new Ball 400, 400, 25
    @stage.addChild @ball
    @ball.draw()

  update:()=>

    window.requestAnimFrame @update

    @renderer.render @stage

