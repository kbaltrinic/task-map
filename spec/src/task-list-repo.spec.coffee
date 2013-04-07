_ =  require 'lodash'
TaskListRepo = require '../../src/task-list-repo'

describe 'src/task-list-repo Tests', () ->

  repo = null

  beforeEach () ->
    repo = new TaskListRepo()
    spyOn repo, 'saveListToFile'

  it "and id property should be added to each task", () ->
    repo.taskList =
      task1:
        title: 'Task 1'

    returnedTaskArray = null

    repo.getTaskList (err, tasks) ->
      console.error err if err?
      returnedTaskArray = tasks

    expect(returnedTaskArray[0]).toEqual {id: 'task1', title: 'Task 1'}

