mongoose = require 'mongoose'

module.exports = (connection, clock) ->  
  dataSchema = new mongoose.Schema
    _id:       String

  dataSchema.set 'collection', 'NodeRegistry'
  
  return mongoose.model 'NodeRegistry', dataSchema
