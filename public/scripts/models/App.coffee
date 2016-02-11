define [
  "backbone"
  "cs!collections/Sheep"
], (Backbone, Sheep)-> Backbone.Model.extend
  initialize: ->
    @sheep = new Sheep
    @listenTo @sheep, 'add', @newRecords

    do @sheep.poll

  newRecords: (m)-> 
    console.log m.attributes._id