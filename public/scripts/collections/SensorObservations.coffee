define [
  'underscore'
  'backbone'
], (_, Backbone)-> Backbone.Collection.extend

  idAttribute: '_id'

  ###
  Perform an initial fetch and then get the latest data every <interval>
  milliseconds
  ###
  poll: (interval = 5000) -> @fetch().always => @repeat interval

  ###
  Repeatedly poll the server for more date after a given interval
  ###
  repeat: (after) -> _.delay (=> @more().always => @repeat after), after

  ###
  Get the latest set of data from the end point
  ###
  more: -> @fetch remove: false, data: since: @last().get 'timestamp'