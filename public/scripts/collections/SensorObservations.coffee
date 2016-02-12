define [
  'underscore'
  'backbone'
], (_, Backbone)-> Backbone.Collection.extend

  idAttribute: '_id'

  ###
  Repeatedly poll the server for more date after a given interval
  ###
  poll: (after = 5000) -> _.delay (=> @more().always => @poll after), after

  ###
  Get the latest set of data from the end point
  ###
  more: -> @fetch remove: false, data: since: @last()?.get 'timestamp'