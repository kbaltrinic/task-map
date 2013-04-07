_ =  require 'lodash'
fs = require 'fs'

class TaskListRepo

  DATA_FILE_NAME = 'data/task-list.json'

  taskList: {}

  constructor: (config) ->
    @readListFromFile()

  getTaskList: (callback)=>
    try
      listWithEmbededIds = _.map @taskList, (task, id) ->
        _.extend {id: id}, task
      callback undefined, listWithEmbededIds
      listWithEmbededIds
    catch e
      callback e

  update: (id, task, callback) =>
    try
      if @taskList[id]?
        @taskList[id] = _.assign @taskList[id], task
        delete @taskList[id].id
        @saveListToFile()
        updatedTask = _.extend (_.cloneDeep @taskList[id]), {id: id}
        callback undefined, updatedTask
        updatedTask
      else
        callback TaskListRepo.NOT_FOUND
    catch e
      callback e

  add: (task, callback) =>
    try
      newId = generateUUID()
      @taskList[newId] = task
      @saveListToFile()
      newTask = _.extend (_.cloneDeep task), {id: newId}
      callback undefined, newTask
      newTask
    catch e
      callback e

  delete: (id, callback) =>
    try
      task = @taskList[id]
      if task?
        delete @taskList[id]
        @saveListToFile()
        callback undefined, _.extend task, {id: id}
        task
      else
        callback TaskListRepo.NOT_FOUND
    catch e
      callback e

  readListFromFile: () =>
    fs.readFile DATA_FILE_NAME, (err, data) ->
      if err?
        console.log "Error!", err
      else
        @taskList = JSON.parse data

  saveListToFile: () =>
    fs.writeFile DATA_FILE_NAME, (JSON.stringify @taskList), (err) -> console.log err

  generateUUID = ->
    d = new Date().getTime()
    uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) ->
      r = (d + Math.random() * 16) % 16 | 0
      d = Math.floor(d / 16)
      ((if c is "x" then r else (r & 0x7 | 0x8))).toString 16
    )
    uuid

TaskListRepo.NOT_FOUND = "E_NOT_FOUND"

module.exports = TaskListRepo
