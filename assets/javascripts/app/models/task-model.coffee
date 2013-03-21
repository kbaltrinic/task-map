define [
  'backbone' 
  ], (Backbone) ->
  
  class TaskModel extends Backbone.Model
    
    # Default attributes for the todo item.
    defaults: ->
      title: "empty todo..."
      order: undefined
      done: false

    
    # Ensure that each todo created has `title`.
    initialize: ->
      @set title: @defaults().title  unless @get("title")

    
    # Toggle the `done` state of this todo item.
    toggle: ->
      @save done: not @get("done")
