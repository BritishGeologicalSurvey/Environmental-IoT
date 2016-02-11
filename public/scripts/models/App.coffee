define [
  "backbone"
  "cs!collections/Sheep"
], (Backbone, Sheep)-> Backbone.Model.extend
  initialize: ->
    @sheep = new Sheep
    @listenTo @sheep, 'add', @newRecords

    do @sheep.fetch
    setInterval( (=> do @sheep.more), 4000)

  newRecords: -> console.log "We now have #{@sheep.length}"