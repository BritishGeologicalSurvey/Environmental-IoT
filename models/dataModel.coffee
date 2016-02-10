mongoose = require 'mongoose'

module.exports = (connection, clock) ->  
  dataSchema = new mongoose.Schema
    _id:       String
    timestamp: Date
    note:      String
    sensor:    String
    address:   String

  dataSchema.set 'collection', 'envdata'
  
  envData = mongoose.model 'envdata', dataSchema

  # Replace the existing find function with one which always filters
  # to timestamp less than the current clock time
  oldFind = envData.find
  envData.find = (query, rest...) ->
    newQuery = $and: [ query, timestamp: $lt: clock.getTime() ]
    oldFind.apply this, [newQuery].concat rest

  return envData