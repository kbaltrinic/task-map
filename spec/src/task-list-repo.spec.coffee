_ =  require 'lodash'
TaskListRepo = require '../../src/task-list-repo'

describe 'src/task-list-repo Tests', () ->

  repo = null

  beforeEach () ->
    repo = new TaskListRepo()
    spyOn repo, 'saveListToFile'

  it "when getting all tasks an id property should be added to each task", () ->
    repo.taskList =
      task1:
        title: 'Task 1'

    returnedTaskArray = null

    repo.getTaskList (err, tasks) ->
      console.error err if err?
      returnedTaskArray = tasks

    expect(returnedTaskArray[0]).toEqual {id: 'task1', title: 'Task 1'}

  describe "when updating a task", () ->

    updateError = null
    updatedTask = null

    beforeEach () ->
      repo.taskList =
        task1:
          title: 'Task 1'

      repo.update 'task1', {id: 'task1', title: 'Updated Task 1'}, (err, task) ->
        updateError = err
        updatedTask = task

    it 'the appropriate task should be updated', () ->
      expect(repo.taskList.task1.title).toEqual 'Updated Task 1'

    it 'the updated task as-stored should not have an id property', () ->
      expect(repo.taskList.task1).toBeDefined()
      expect(repo.taskList.task1.id).toBeUndefined()

    it 'the updated task as-returned should be updated', () ->
      expect(updatedTask.title).toEqual 'Updated Task 1'

    it 'the updated task as-returned should have an id property', () ->
      expect(updatedTask.id).toEqual 'task1'

    it 'no error should be returned', () ->
      expect(updateError).toBeUndefined()

  describe "when updating a non-existing task", () ->

    updateError = null
    updatedTask = null

    priorRepoState =
      task1:
        title: 'Task 1'

    beforeEach () ->
      repo.taskList = _.cloneDeep priorRepoState

      repo.update 'task2', {id: 'task2', title: 'Updated Task 1'}, (err, task) ->
        updateError = err
        updatedTask = task

    it 'a not-found error should be returned', () ->
      expect(updateError).toEqual TaskListRepo.NOT_FOUND

    it 'the repo state should be unchanged', () ->
      expect(repo.taskList).toEqual priorRepoState

    it 'no task should be returned', () ->
      expect(updatedTask).toBeUndefined

  describe "when adding a task", () ->

    addError = null
    addedTask = null

    beforeEach () ->
      repo.taskList =
        task1:
          title: 'Task 1'

      repo.add {title: 'Added Task 2'}, (err, task) ->
        addError = err
        addedTask = task

    it 'a new task should be added under a unique id', () ->
      expect(repo.taskList[addedTask.id]).toBeDefined()
      expect(repo.taskList[addedTask.id].title).toEqual 'Added Task 2'

    it 'the added task as-stored should not have an id property', () ->
      expect(repo.taskList[addedTask.id].id).toBeUndefined()

    it 'the added task as-returned should be as expected', () ->
      expect(addedTask.title).toEqual 'Added Task 2'

    it 'the added task as-returned should have an id', () ->
      expect(addedTask.id).toBeDefined()

    it 'no error should be returned', () ->
      expect(addError).toBeUndefined()

  describe "when deleting a task", () ->

    deleteError = null
    deleteTask = null

    beforeEach () ->
      repo.taskList =
        task1:
          title: 'Task 1'
        task2:
          title: 'Task 2'

      repo.delete 'task1', (err, task) ->
        deleteError = err
        deleteTask = task

    it 'the appropriate task should be deleted', () ->
      expect(repo.taskList.task1).toBeUndefined

    it 'no other tasks to be deleted', () ->
      expect(repo.taskList.task2).toBeDefined

    it 'the deleted task should be updated', () ->
      expect(deleteTask.title).toEqual 'Task 1'

    it 'the deleted task as-returned should have an id property', () ->
      expect(deleteTask.id).toEqual 'task1'

    it 'no error should be returned', () ->
      expect(deleteError).toBeUndefined()

  describe "when deleting a non-existing task", () ->

    deleteError = null
    deleteTask = null

    priorRepoState =
      task1:
        title: 'Task 1'
      task2:
        title: 'Task 2'

    beforeEach () ->
      repo.taskList = _.cloneDeep priorRepoState

      repo.delete 'task3', (err, task) ->
        deleteError = err
        deleteTask = task

    it 'a not-found error should be returned', () ->
      expect(deleteError).toEqual TaskListRepo.NOT_FOUND

    it 'the repo state should be unchanged', () ->
      expect(repo.taskList).toEqual priorRepoState

    it 'no task should be returned', () ->
      expect(deleteTask).toBeUndefined
