define [], () ->
  class QuickEntryService
    QuickEntryService.parse = (input, addTaskCallback) -> 
      tasks = input.split "\n"
      addTaskCallback(title: task) for task in tasks
      return