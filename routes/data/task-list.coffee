_ =  require 'lodash'
fs = require 'fs'

class TaskListRoutes

  taskList = 
    '1':
      title: "Test Task 1"
      order: 1
      done: false
    '2':
      title: "Test Task 2"
      order: 2
      done: true
    '3':
      title: "Test Task 3"
      order: 3
      done: false

  constructor: (config) ->

    fs.readFile 'task-list.json', (err, data) ->
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
    fs.writeFile 'task-list.json', JSON.stringify taskList
      
module.exports = TaskListRoutes