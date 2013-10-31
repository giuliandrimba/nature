AppView = require 'app/views/app_view'
Circle = require "board/geometry/circle"

module.exports = class Vectors extends AppView

  after_render:()->

    @ctx = window.Sketch.create

      container:@el.get(0)

      draw:()->
        @beginPath();
        @arc( random( @width ), random( @height ), 10, 0, TWO_PI );
        @fill();

