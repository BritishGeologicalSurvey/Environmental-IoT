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
    @soil  = @createSoil()
    @sheep = @createSheep()

    @clock.poll()
    @nodeRegistry.fetch().complete =>
      do @soil.poll
      do @sheep.poll

  ###
  Return a new collection of sheep observations which is bound to this models
  node registry.
  ###
  createSheep: -> new Sheep [], registry: @nodeRegistry

  ###
  Return a new collection of soil observations bound to this modules node registry
  ###
  createSoil: -> new Soil  [], registry: @nodeRegistry