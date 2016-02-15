define [
  "backbone"
  "cs!collections/Sheep"
  "cs!collections/Soil"
], (Backbone, Sheep, Soil)-> Backbone.Model.extend
  
  initialize: ->
    @sheep = new Sheep
    do @sheep.poll # Start repeated listening
    
    @soil = new Soil
    do @soil.poll
