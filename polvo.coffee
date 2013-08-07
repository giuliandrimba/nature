theoricus = 'vendors/theoricus/www'

setup
  
  # ----------------------------------------------------------------------------
  # SERVER

  server:
    root: 'public'
    port: 11235

  # ----------------------------------------------------------------------------
  # INPUT FOLDERS AND FILES

  # source folders
  sources: [
    'src'
    "#{theoricus}/src"
  ]

  # excluded folders (if informed, all others will be included)
  exclude: []

  # included folders (if informed, all others will be excluded)
  include: []

  # ----------------------------------------------------------------------------
  # OUTPUT FOLDERS AND FILES
  
  # destination dir for everything
  destination: 'public/js'

  # main file to be included in your html, development and release files will
  # have this name (inside destinaton folder)
  index: 'app.js'

  # ----------------------------------------------------------------------------
  # BASIC AMD CONFIG

  # path to reach the `js` folder through http
  base_url: '/js'

  # main module to be loaded
  main_module: 'app/app'

  # ----------------------------------------------------------------------------
  # VENDORS

  vendors:

    javascript:

      # theoricus
      'json': "#{theoricus}/vendors/json2.js"
      'history': "#{theoricus}/vendors/history.js"
      'inflection': "#{theoricus}/vendors/inflection.js"
      'jquery': "#{theoricus}/vendors/jquery.js"
      'lodash': "#{theoricus}/vendors/lodash.js"
      'jquery.spritefy': "vendors/jquery/jquery.spritefy.js"
      'stats': "vendors/utils/stats.js"

      # app
      # 'app_vendor_name': 'vendors/app_vendor_name.js'

      # vendors that doesn't implements AMD
      incompatible: [
          # theoricus
          'history', 'inflection', 'jquery', 'json','jquery.spritefy', 'stats'

          # app
          # 'app_vendor'
        ]

    # css:
    #   'xyz':  'bla'

  # ----------------------------------------------------------------------------
  # OPTIMIZATION

  optimize:
    minify: true
    merge: true