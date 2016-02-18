express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
index        = require '../routes/index'
rest         = require '../routes/rest'

module.exports = (envData, nodeRegistry, clock)->
  app = express()

  # view engine setup
  app.set 'views', path.join __dirname, '../views'
  app.set 'view engine', 'jade'
  # app.set('port', process.env.PORT || 8080);
  # uncomment after placing your favicon in /public
  #app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
  # app.use(logger('dev'));
  app.use bodyParser.json()
  app.use bodyParser.urlencoded extended: false 
  app.use cookieParser()

  app.use express.static path.join __dirname, '../public'

  app.use '/', rest(envData, nodeRegistry, clock)
  app.use '/', index()

  # catch 404 and forward to error handler
  app.use (req, res) ->
    res.status 404
    switch
      when req.accepts 'html' then res.render '404', url: req.url
      when req.accepts 'json' then res.send error: 'Not found'
      else res.type('txt').send 'Not found'

  # error handlers
  # development error handler
  # will print stacktrace
  app.use (err, req, res) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: if app.get('env') is 'development' then err else {}

  return app