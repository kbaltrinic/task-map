TaskListRepo =  require '../../src/task-list-repo'

class TaskListRoutes

  repo = null;
  
  constructor: (config) ->
    repo = new TaskListRepo(config)
    
  get: (req, res) -> 
    repo.getTaskList (err, taskList) ->
      if err?
        respondToError res, err
      else
        res.json taskList
        
  put: (req, res) ->
    repo.update req.params.id, req.body, (err, updatedTask) -> 
      if err?
        respondToError res, err, req.params.id
      else
        res.json updatedTask
        
  post: (req, res) ->
    repo.add req.body, (err, newTask) -> 
      if err?
        respondToError res, err
      else
        res.json newTask

  delete: (req, res) ->
    repo.delete req.params.id, (err) -> 
      if err?
        respondToError res, err, req.params.id
      else
        res.send ""

  respondToError = (res, err, id)->
    console.log "Error handling request: #{err}"
    if err == TaskListRepo.NOT_FOUND 
      res.send 404, {error: "No task found with Id: #{id}"}
    else
      res.send 500, {error: err}
      
module.exports = TaskListRoutes