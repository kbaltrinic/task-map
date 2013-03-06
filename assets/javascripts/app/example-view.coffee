define ['jquery', 'backbone', 'templates'], ($, Backbone, templates) ->

  class ExampleView extends Backbone.View

    render: (element) ->
      templates.render 'example', {name:'Dust', css:'stylus'}, (err, out) ->
        $(element).append out
      templates.render 'another-example', {name:'Dust'}, (err, out) ->
        $(element).append out

  ExampleView