define [
  "backbone"
  'cs!models/Clock'
  'cs!collections/NodeRegistry'
  "cs!collections/Soil"
  "cs!collections/Sheep"
], (Backbone, Clock, NodeRegistry, Soil, Sheep)-> Backbone.Model.extend
  
  initialize: ->
    @clock = new Clock
    @nodeRegistry = new NodeRegistry
    @soil  = new Soil  [], registry: @nodeRegistry
    @sheep = new Sheep [], registry: @nodeRegistry

    @clock.fetch()
    @nodeRegistry.fetch().complete =>
      do @soil.poll  # Start repeated listening
      do @sheep.poll

  getHistoricSheep: -> new Sheep [], registry: @nodeRegistry