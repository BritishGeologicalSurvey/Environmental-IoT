define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
  'cs!views/SensorPositionView'
  'cs!views/NodeStatusView'
  'cs!views/SoilMoistureView'
  'cs!views/SheepStatusView'
], ($, Backbone, SheepPositionMap, SensorPositionView, NodeStatusView, SoilMoistureView, SheepStatusView)-> Backbone.View.extend

  initialize: ->
    if $(SheepPositionMap.prototype.el).length
      @sheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes

    if $(SensorPositionView.prototype.el).length
      @sensorPositionView = new SensorPositionView collection: @model.soil.nodes

    if $(NodeStatusView.prototype.el).length
      @nodeStatusView = new NodeStatusView model: @model

    if $(SoilMoistureView.prototype.el).length
      @SoilMoistureView = new SoilMoistureView collection: @model.soil.nodes

    if $(SheepStatusView.prototype.el).length
      @sheepStatusView = new SheepStatusView model: @model