mongoose = require 'mongoose'
clock    = require './SensorsClock'

dataSchema = new mongoose.Schema
  _id:       String
  timestamp: Date
  note:      String
  sensor:    String
  address:   String

dataSchema.set 'collection', 'envdata'
EnvData = mongoose.model 'envdata', dataSchema

module.exports = 
  find: (query, rest...) ->
    newQuery = $and: [ query, timestamp: $lt: clock.getTime() ]
    EnvData.find newQuery, rest...