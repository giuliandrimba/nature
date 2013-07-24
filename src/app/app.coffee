Theoricus = require 'theoricus/theoricus'

Settings = require 'app/config/settings'
Routes = require 'app/config/routes'

module.exports = class App extends Theoricus

  constructor:( Settings, Routes )->
    # don't forget to extend Theoricus and pass Settings and Routes !
    super Settings, Routes
    @start()

# initialize your app
new App Settings, Routes