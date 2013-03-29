require
  shim: 
    underscore: 
      exports: '_'
    backbone: 
      deps: ["underscore", "jquery"],
      exports: "Backbone"
  paths:
    jquery: '../public/javascripts/vendor/jquery-1.9.1'
    underscore: '../public/javascripts/vendor/underscore'
    lodash: '../public/javascripts/vendor/lodash'
    backbone:   '../public/javascripts/vendor/backbone'
  , ['app/domain/quick-entry-service-spec']
  , ['selenium/smoke-test']
  , () ->
      env = jasmine.getEnv() 
      env.addReporter new jasmine.HtmlReporter 
      env.execute() 
