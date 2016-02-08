express      = require 'express'
http         = require 'http'
debug        = require('debug') 'Environmental-IoT:server'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
mongoose     = require 'mongoose'
index       = require '../routes/Index'
rest         = require '../routes/Rest'

module.exports = class
  constructor: () ->
    @database = @connectToDatabase()
    @express  = @createExpress()
    @server(@express)

  connectToDatabase: ->
    console.log 'Connecting to local database'
    
    mongoose.set 'debug', true
    mongoose.connect 'mongodb://localhost/envdata', (err) ->
      if err then console.log 'Connection error', err
      else console.log 'Connection successful'
  
  createExpress: ->
    app = express()

    console.log('Node Env = ' + app.get('env'));

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

    app.use '/', rest()
    app.use '/', index()

    # catch 404 and forward to error handler
    app.use (req, res, next) ->
      switch
        when res.accepts 'html' then res.render '404', url: req.url
        when req.accepts 'json' then res.send error: 'Not found'
        else res.type('txt').send 'Not found'

    # error handlers
    # development error handler
    # will print stacktrace
    app.use (err, req, res, next) ->
      res.status err.status or 500
      res.render 'error',
        message: err.message
        error: if app.get('env') is 'development' then err else {}

    return app

  server: (app)->
    # Normalize a port into a number, string, or false.
    normalizePort = (val)->
      port = parseInt(val, 10);

      return val if isNaN port
      return port if port >=0
      return false;

    port = normalizePort process.env.PORT or '3000'
    app.set 'port', port

    #Create HTTP server.
    server = http.createServer app

    # Listen on provided port, on all network interfaces.
    server.listen port
    # Event listener for HTTP server "error" event.
    server.on 'error', (error) ->
      if error.syscall not 'listen' then throw error

      bind = if typeof port is 'string' then "Pipe #{port}" else "Port #{port}"

      # handle specific listen errors with friendly messages
      switch error.code
        when 'EACCES'
          console.error bind + ' requires elevated privileges'
          process.exit 1
        when 'EADDRINUSE'
          console.error bind + ' is already in use'
          process.exit 1
        else throw error

    # Event listener for HTTP server "listening" event.
    server.on 'listening', ->
      addr = server.address()
      bind = if typeof addr is 'string' then "pipe #{addr}" else "port #{addr.port}"
      debug "Listening on #{bind}"

    return server
