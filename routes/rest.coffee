###
  /api/points	GET					Get all the points.
  /api/points/:point_id		GET	Get a single point by its id.
###
express = require 'express'

module.exports = (dataModel, clock) ->
  router = express.Router()

  ###
  Get the current system time
  ###
  router.get '/time', (req, res) ->
    res.json systemTime: clock.getTime()

  recordsFor = (types, since, callback) ->
    query = sensor: $in: types # basic query
    query.timestamp = "$gt": new Date since if since? 
    
    dataModel.find(query, callback).sort(timestamp: -1).limit 1000

  ###
  Get the latest sheep data
  Optionally return just the latest records after a specified datetime query param
  ###
  router.get '/sheep', (req, res) -> 
    recordsFor ['gps'], req.query.since, (err, data) ->  res.json data.reverse()

  ###
  Get the latest soil data
  Optionally return just the latest records after a specified datetime query param
  ###
  router.get '/soil', (req, res) ->
    recordsFor ['soil','soil1','soil2'], req.query.since, (err, data) ->  res.json data.reverse()
    
  ###
  Get the latest met station data
  Optionally return just the latest records after a specified datetime query param
  ###
  router.get '/metstation', (req, res) ->
    recordsFor ['metstation'], req.query.since, (err, data) ->  res.json data.reverse()
    