define [
  "backbone"
  "cs!collections/Sheep"
], (Backbone, Sheep)-> Backbone.Model.extend
  
  initialize: ->
    @sheep = new Sheep
    do @sheep.poll # Start repeated listening
