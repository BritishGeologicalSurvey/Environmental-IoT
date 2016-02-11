define [
  "backbone"
], (Backbone)-> Backbone.Collection.extend

  ###
  Get the latest set of data from the end point
  ###
  more: ->
    @fetch remove: false, data: since: @last().get 'timestamp'