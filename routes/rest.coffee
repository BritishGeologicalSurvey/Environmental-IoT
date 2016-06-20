###
  /api/points	GET					Get all the points.
  /api/points/:point_id		GET	Get a single point by its id.
###
express = require 'express'

module.exports = (envdata, nodeRegistry, clock) ->
  router = express.Router()

  router.get '/timeranges', (req, res) ->
    res.json systemTime: clock.ranges

  ###
  Get the current system time
  ###
  router.get '/time', (req, res) ->
    res.json systemTime: clock.getTime()

  recordsFor = (types, since, callback) ->
    twentyFourHours = 24 * 60 * 60 * 1000
    today = new Date clock.getTime()
    today.setHours 0,0,0,0

    timestamp = if since? then new Date since else today

    # console.log timestamp

    query =
      sensor: $in: types # basic query
      timestamp:
        $gt: timestamp
        $lt: new Date timestamp.getTime() + twentyFourHours

    envdata.find(query, callback).sort(timestamp: -1)

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
  router.get '/weather', (req, res) ->
    recordsFor ['metstation'], req.query.since, (err, data) ->  res.json data.reverse()

  router.get '/nodes', (req, res) ->
    sheep = [
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":\"0xd0\"}]'
        node_type: 'Sheep'
        colour:    '#00ccff'
        icon:      '/img/Blue-Sheep.png'
      ,
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":\"0xd1\"}]'
        node_type: 'Sheep'
        colour:    '#87de87'
        icon:      '/img/Green-Sheep.png'
      ,
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":\"0x1f6\"}]'
        node_type: 'Sheep'
        colour:    '#ff9955'
        icon:      '/img/Orange-Sheep.png'
      ,
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":\"0x0\"}]'
        node_type: 'Sheep'
        colour:    '#cc00ff'
        icon:      '/img/Purple-Sheep.png'
      ,
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":\"0xff\"}]'
        node_type: 'Sheep'
        colour:    '#d35f5f'
        icon:      '/img/Red-Sheep.png'
      ,
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":\"0xd3\"}]'
        node_type: 'Sheep'
        colour:    '#00ffcc'
        icon:      '/img/Turquoise-Sheep.png'
      ,
        address:   '[{\"interface-type\":\"SHEEP\",\"address\":211}]'
        node_type: 'Sheep'
        colour:    '#ffdd55'
        icon:      '/img/Yellow-Sheep.png'
    ]
    nodeRegistry.find (err,data) -> res.json sheep.concat data
