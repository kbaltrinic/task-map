require
  #urlArgs: "b=#{(new Date()).getTime()}"
  shim: 
    underscore: 
      exports: '_'
    backbone: 
      deps: ["underscore", "jquery"],
      exports: "Backbone"
  paths:
    jquery: 'vendor/jquery-1.9.1'
    underscore: 'vendor/underscore'
    backbone:   'vendor/backbone'
  , ['app/views/app-view']
  , (AppView) ->
    view = new AppView()
    view.render('body')