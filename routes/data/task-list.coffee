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
      
module.exports = TaskListRoutes