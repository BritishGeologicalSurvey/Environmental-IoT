define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
  'cs!views/SensorPositionView'
  'cs!views/NodeStatusView'
  'cs!views/SheepStatusView'
  'cs!views/SheepHeatMapView'
  'cs!views/SoilLocationView'
], ($, Backbone, SheepPositionMap, SensorPositionView, NodeStatusView, SheepStatusView, SheepHeatMapView, SoilLocationView)-> Backbone.View.extend

  initialize: ->
    if $(SheepPositionMap.prototype.el).length
      @sheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes

    if $(SensorPositionView.prototype.el).length
      @sensorPositionView = new SensorPositionView collection: @model.soil.nodes

    if $(NodeStatusView.prototype.el).length
      @nodeStatusView = new NodeStatusView 
        collection:   @model.soil.nodes
        nodeRegistry: @model.nodeRegistry
        type:         'Soil'

    sheepNodeStatusEl = '#sheepNodeStatus'
    if $(sheepNodeStatusEl).length
      @nodeStatusView = new NodeStatusView 
        collection:   @model.sheep.nodes
        nodeRegistry: @model.nodeRegistry
        type:         'Sheep'
        el:           sheepNodeStatusEl

    if $(SheepStatusView.prototype.el).length
      @sheepStatusView = new SheepStatusView model: @model

    if $(SheepHeatMapView.prototype.el).length
      @sheepHeatMapView = new SheepHeatMapView model: @model

    if $(SoilLocationView.prototype.el).length
      @soilLocationView = new SoilLocationView collection: @model.soil.nodes