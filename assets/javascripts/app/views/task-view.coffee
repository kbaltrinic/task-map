define [
  'jquery', 
  'backbone', 
  'templates', 
  'app/models/task-list'
  ], ($, Backbone, templates, Todos) ->

  class TaskView extends Backbone.View
   
    #... is a list tag.
    tagName: "li"
    
    # The DOM events specific to an item.
    events:
      "click .toggle": "toggleDone"
      "dblclick .view": "edit"
      "click a.destroy": "clear"
      "keypress .edit": "updateOnEnter"
      "blur .edit": "close"

    
    # The TodoView listens for changes to its model, re-rendering. Since there's
    # a one-to-one correspondence between a **Todo** and a **TodoView** in this
    # app, we set a direct reference on the model for convenience.
    initialize: ->
      @listenTo @model, "change", @render
      @listenTo @model, "destroy", @remove

    
    # Re-render the titles of the todo item.
    render: ->
      templates.render 'task-view', @model.attributes, (err, out) => 
        @$el.html out
      @$el.toggleClass "done", @model.get("done")
      @input = @$(".edit")
      this

    
    # Toggle the `"done"` state of the model.
    toggleDone: ->
      @model.toggle()

    
    # Switch this view into `"editing"` mode, displaying the input field.
    edit: ->
      @$el.addClass "editing"
      @input.focus()

    
    # Close the `"editing"` mode, saving changes to the todo.
    close: ->
      value = @input.val()
      unless value
        @clear()
      else
        @model.save title: value
        @$el.removeClass "editing"

    
    # If you hit `enter`, we're through editing the item.
    updateOnEnter: (e) ->
      @close()  if e.keyCode is 13

    
    # Remove the item, destroy the model.
    clear: ->
      @model.destroy()
