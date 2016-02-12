define [
  'jquery'
  'backbone'
  'cs!views/SheepPositionMap'
], ($, Backbone, SheepPositionMap)-> Backbone.View.extend

  initialize: ->
    @SheepPositionMap = new SheepPositionMap collection: @model.sheep.nodes