define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
  'cs!views/SoilMoistureChart'
], ($, Backbone, SheepPositionMap, SoilMoistureChart)-> Backbone.View.extend

  initialize: ->
    # @SheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes
    @SoilMoistureChart = new SoilMoistureChart collection: @model.soil.nodes
