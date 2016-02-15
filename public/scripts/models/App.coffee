define [
  "backbone"
  'cs!collections/NodeRegistry'
  "cs!collections/Soil"
  "cs!collections/Sheep"
], (Backbone, NodeRegistry, Soil, Sheep)-> Backbone.Model.extend
  
  initialize: ->
    @nodeRegistry = new NodeRegistry
    @soil  = new Soil  [], registry: @nodeRegistry
    @sheep = new Sheep [], registry: @nodeRegistry

    @nodeRegistry.fetch().complete =>
      do @soil.poll
      do @sheep.poll
