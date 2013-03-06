require
  urlArgs: "b=#{(new Date()).getTime()}"
  shim: 
    underscore: 
      exports: '_'
    backbone: 
      deps: ["underscore", "jquery"],
      exports: "Backbone"
  paths:
    jquery: 'vendor/jquery'
    underscore: 'vendor/underscore'
    backbone:   'vendor/backbone'
  , ['app/example-view']
  , (ExampleView) ->
    view = new ExampleView()
    view.render('body')