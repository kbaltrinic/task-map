_ =  require 'lodash'
fs = require 'fs'

class TaskListRoutes

  dataFileName = 'data/task-list.json'
 
  taskList = {}
  
  constructor: (config) ->

    fs.readFile dataFileName, (err, data) ->
      if err? 
        console.log(err)
      else
        taskList = JSON.parse data
  
  get: (req, res) -> 
    res.json _.map taskList, (task, id) ->
      _.extend {id: id}, task
      
  put: (req, res) ->
    id = req.params.id
    updatedTask = req.body
    delete updatedTask.id
    taskList[id] = _.assign taskList[id], req.body
    fs.writeFile dataFileName, JSON.stringify taskList

  post: (req, res) ->
    newTask = req.body
    newId = generateUUID()
    taskList[newId] = newTask
    fs.writeFile dataFileName, JSON.stringify taskList
    res.json {id: newId}

  delete: (req, res) ->
    id = req.params.id
    delete taskList[id]
    fs.writeFile dataFileName, JSON.stringify taskList

  generateUUID = ->
    d = new Date().getTime()
    uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, (c) ->
      r = (d + Math.random() * 16) % 16 | 0
      d = Math.floor(d / 16)
      ((if c is "x" then r else (r & 0x7 | 0x8))).toString 16
    )
    uuid
      
module.exports = TaskListRoutes