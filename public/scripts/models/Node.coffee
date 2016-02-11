define [
  "backbone"
], (Backbone, Sheep)-> Backbone.Model.extend
  initialize: ->
    @observations = new Backbone.Collection