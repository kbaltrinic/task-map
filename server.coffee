express =        require 'express'
engines =        require 'consolidate'

routes  =        require './routes'
TaskListRoutes = require './routes/data/task-list'

exports.startServer = (config, callback) ->

  app = express()
  server = app.listen config.server.port, ->
    console.log "Express server listening on port %d in %s mode", server.address().port, app.settings.env

  app.configure ->
    app.set 'port', config.server.port
    app.set 'views', config.server.views.path
    app.engine config.server.views.extension, engines[config.server.views.compileWith]
    app.set 'view engine', config.server.views.extension
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    #Commenting this out for now because it keeps crashing express 
    #app.use express.compress()
    app.use config.server.base, app.router
    app.use express.static(config.watch.compiledDir)

  app.configure 'development', ->
    app.use express.errorHandler()

  app.get '/', routes.index(config)

  taskListRountes = new TaskListRoutes(config)
  app.get '/data/task-list', taskListRountes.get
  app.put '/data/task-list/:id', taskListRountes.put
  app.post '/data/task-list', taskListRountes.post
  app.delete '/data/task-list/:id', taskListRountes.delete
  
  callback(server)

