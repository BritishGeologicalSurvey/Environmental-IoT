define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
  'cs!views/SensorPositionView'
  'cs!views/NodeStatusView'
], ($, Backbone, SheepPositionMap, SensorPositionView, NodeStatusView, SoilMoistureChart)-> Backbone.View.extend
  'cs!views/SoilMoistureChart'

  initialize: ->
    if $(SheepPositionMap.prototype.el).length
      @sheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes

    if $(SensorPositionView.prototype.el).length
      @sensorPositionView = new SensorPositionView collection: @model.soil.nodes

    if $(NodeStatusView.prototype.el).length
      @nodeStatusView = new NodeStatusView model: @model

	    if $(SoilMoistureChart.prototype.el).length
    @SoilMoistureChart = new SoilMoistureChart collection: @model.soil.nodes