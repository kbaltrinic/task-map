define [], () ->
  class QuickEntryService
    QuickEntryService.parse = (input, addTaskCallback) -> 
      tasks = input.split "\n"
      addTaskCallback(title: task.trim()) for task in tasks when task.trim().length > 0
      return