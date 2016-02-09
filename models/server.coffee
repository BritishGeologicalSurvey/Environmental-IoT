debug = require('debug') 'Environmental-IoT:server'
http  = require 'http'

module.exports = (app)->
  # Normalize a port into a number, string, or false.
  normalizePort = (val)->
    port = parseInt val, 10

    return val if isNaN port
    return port if port >=0
    return false

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
