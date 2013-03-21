define [], () ->
  class StatsViewModel
    constructor: (@taskList) ->
      
    showStats: => @taskList.length > 0
    someAreDone: => @done() > 0 
    done: => @taskList.done().length
    remaining: => @taskList.remaining().length
    doneIsSingular: => @done() == 1
    remainingIsSingular: => @done() == 1
    