###
  /api/points	GET					Get all the points.
  /api/points/:point_id		GET	Get a single point by its id.
###
express = require 'express'

module.exports = (dataModel, clock) ->
  router = express.Router()

  ###
    Query Building from URL params
    Expecting:
    - e.g. http://<sitelocation>:<port>/api?sensor=sheep&starttime=xxxxx&endtime=xxxxx
    - sensor=sheep or sensor=soil
    - starttime=xxxxx (ISO Date format)
    - endtime=xxxxx (ISO Date format)

    http://localhost:3000/querynode?nodeid=A6&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z
  ###
  router.get '/api', (req, res) ->
    dataModel.find
      $and: [
        timestamp:
          "$gte": new Date req.query.starttime
          "$lt":  new Date req.query.endtime
      ,
        sensor: req.query.sensor
      ], (err, posts) -> res.json posts

  ###
  Get the current system time
  ###
  router.get '/time', (req, res) ->
    res.json systemTime: clock.getTime()

  ###
  Getting values from nodes and their sensors
  ###
  router.get '/querynode', (req, res)->
    moisture_exists = req.query.packet is 1

    dataModel.find
      $and: [
        timestamp: 
          "$gte": new Date req.query.starttime
          "$lt":  new Date req.query.endtime
      ,
        address: req.query.nodeid
        soil_moisture_1: $exists: moisture_exists
      ], (err, posts) ->  res.json posts

  router.get '/querysoil', (req, res)->
    dataModel.find
      $and: [
        timestamp: 
          "$gte": new Date req.query.starttime
          "$lt": new Date req.query.endtime
      ,
        address: req.query.nodeid
      ], (err, posts) -> res.json posts

  ###
  Get all the points up to a limit of 50
  ###
  router.get '/api/points', (req, res, next)->
    dataModel.find {}, (err, posts)->
        if not err then res.json posts
        else throw err
    .limit 50

  ###
  Get a single point by its id.
  ###
  router.get '/api/points/:id', (req, res, next)->
    dataModel.findById req.params.id, (err, results)->
      if err then return next err
      if not results then res.send "NODATA"
      else res.json results

  return router