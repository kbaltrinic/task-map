_ =  require 'lodash'
fs = require 'fs'

class TaskListRepo

  DATA_FILE_NAME = 'data/task-list.json'
 
  _taskList = {}
  
  constructor: (config) ->
    readListFromFile()
  
  getTaskList: (callback)-> 
    try
      list = _.map _taskList, (task, id) ->
        _.extend {id: id}, task
      callback undefined, list
      list
    catch e
      callback e
       
  update: (id, task, callback) ->
    try
      if _taskList[id]? 
        _taskList[id] = _.assign _taskList[id], task
        delete _taskList[id].id
        saveToFile()
        updatedTask = _.extend _taskList[id], {id: id}
        callback undefined, updatedTask
        updatedTask
      else
        callback TaskListRepo.NOT_FOUND
    catch e
      callback e
    
  add: (task, callback) ->
    try
      newId = generateUUID()
      _taskList[newId] = task
      saveToFile()
      newTask = _.extend task, {id: newId}
      callback undefined, newTask
      newTask
    catch e
      callback e

  delete: (id, callback) ->
    try
      task = _taskList[id]
      if task? 
        delete _taskList[id]
        saveToFile()
        callback undefined, task
        task
      else
        callback TaskListRepo.NOT_FOUND
    catch e
      callback e
  
  readListFromFile = ->
    fs.readFile DATA_FILE_NAME, (err, data) ->
      if err? 
        console.log "Error!", err 
      else
        _taskList = JSON.parse data
    
  saveToFile = ->
    fs.writeFile DATA_FILE_NAME, (JSON.stringify _taskList), (err) -> console.log err
  
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