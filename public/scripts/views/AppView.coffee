define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
], ($, Backbone, SheepPositionMap)-> Backbone.View.extend

  initialize: ->
    if $(SheepPositionMap.prototype.el).length
      @sheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes