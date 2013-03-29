define ['lodash'], (_) ->
  class QuickEntryService
    QuickEntryService.parse = (input, addTaskCallback) -> 
      tasks = input.split "\n"
      taskStack = []
      for task in tasks when task.trim().length > 0
        rawTask = task.replace(/\s+$/, '').replace "\t", " " #right trim and equalize \t to " "
        title = rawTask.trim()
        indent = rawTask.length - title.length
        task = 
          title: title
          tasks: []
        taskStack[indent] = task    #adds current task at its indent level (array auto-sizes)
        taskStack.splice indent + 1 #truncates array to eliminate any tasks at a greater indent level
        if indent == 0
          #a top level task is itself returned
          addTaskCallback(task)
        else
          found = false
          #all other tasks are added to the task at the next highest indent level
          for i in [indent - 1..0]
            if taskStack[i]?
              found = true
              taskStack[i].tasks.push task
              break
          #unless no such task is found.
          addTaskCallback(task) unless found
      return
