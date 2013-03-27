define ['lodash'], (_) ->
  class QuickEntryService
    QuickEntryService.parse = (input, addTaskCallback) -> 
      tasks = input.split "\n"
      taskStack = []
      currentIndent = 0
      for task in tasks when task.trim().length > 0
        rawTask = task.replace(/\s+$/, '').replace "\t", " " 
        title = rawTask.trim()
        indent = rawTask.length - title.length
        task = title: title
        if taskStack.length == 0 
          taskStack.push task
          currentIndent = indent
          addTaskCallback(task) 
        else if indent > currentIndent
          _.last(taskStack).tasks = [ task ]
        else
          addTaskCallback(task) 
          
      return
  