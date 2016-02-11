define [
  "backbone"
], (Backbone)-> Backbone.Model.extend
  initialize: ->
    @observations = new Backbone.Collection