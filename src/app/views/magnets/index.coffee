AppView = require 'app/views/app_view'

module.exports = class Index extends AppView

  after_render:=>

    @ctx = window.Sketch.create

      container:@el.get(0)

      setup:->

      update:->

      draw:->