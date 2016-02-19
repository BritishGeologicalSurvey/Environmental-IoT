define [
  "backbone"
  'cs!models/Clock'
  'cs!collections/NodeRegistry'
  "cs!collections/Soil"
  "cs!collections/Sheep"
  "cs!collections/Weather"
], (Backbone, Clock, NodeRegistry, Soil, Sheep, Weather)-> Backbone.Model.extend
  
  initialize: ->
    @clock = new Clock
    @nodeRegistry = new NodeRegistry
    @soil  = @createSoil()
    @sheep = @createSheep()
    @weather = @createWeather()

    @clock.poll()
    @nodeRegistry.fetch().complete =>
      do @soil.poll
      do @sheep.poll
      do @weather.poll

  ###
  Return a new collection of sheep observations which is bound to this models
  node registry.
  ###
  createSheep: -> new Sheep [], registry: @nodeRegistry

  ###
  Return a new collection of soil observations bound to this modules node registry
  ###
  createSoil: -> new Soil  [], registry: @nodeRegistry
  ###
  Return a new collection of weather observations bound to this modules node registry
  ###
  createWeather: -> new Weather  [], registry: @nodeRegistry