define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
  'cs!views/SensorPositionView'
  'cs!views/NodeStatusView'
  'cs!views/SoilMoistureView'
], ($, Backbone, SheepPositionMap, SensorPositionView, NodeStatusView, SoilMoistureView)-> Backbone.View.extend
  'cs!views/SoilMoistureChart'

  initialize: ->
    if $(SheepPositionMap.prototype.el).length
      @sheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes

    if $(SensorPositionView.prototype.el).length
      @sensorPositionView = new SensorPositionView collection: @model.soil.nodes

    if $(NodeStatusView.prototype.el).length
      @nodeStatusView = new NodeStatusView model: @model

    if $(SoilMoistureView.prototype.el).length
      @SoilMoistureView = new SoilMoistureView collection: @model.soil.nodes