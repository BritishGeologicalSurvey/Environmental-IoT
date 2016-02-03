var mongoose = require('mongoose');

var dataSchema = new mongoose.Schema({
  _id: String,
  timestamp: Date,
  note: String,
  sensor: String,
  address: String
});

dataSchema.set('collection', 'envdata');
var Item = mongoose.model('envdata', dataSchema);

module.exports = Item;
