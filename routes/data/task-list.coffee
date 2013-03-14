fs = require 'fs'

class TaskListRoutes

  taskList = [
    title: "Test Task 1"
    order: 1
    done: false
  ,
    title: "Test Task 2"
    order: 2
    done: true
  ,
    title: "Test Task 3"
    order: 3
    done: false
  ]

  constructor: (config) ->

    fs.readFile 'task-list.json', (err, data) ->
      if err? 
        console.log(err)
      else
        taskList = JSON.parse data
  
  get: (req, res) -> 
    res.json taskList
    
module.exports = TaskListRoutes