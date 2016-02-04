mongoose = require 'mongoose'

dataSchema = new mongoose.Schema
  _id:       String
  timestamp: Date
  note:      String
  sensor:    String
  address:   String

dataSchema.set 'collection', 'envdata'

module.exports = mongoose.model 'envdata', dataSchema
