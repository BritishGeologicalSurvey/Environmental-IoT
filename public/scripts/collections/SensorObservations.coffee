define [
  'underscore'
  'backbone'
  'cs!collections/Nodes'
], (_, Backbone, Nodes)-> Backbone.Collection.extend

  idAttribute: '_id'

  initialize: (models, options) ->
    @registry = options.registry
    @nodes = new Nodes

    @on 'add', @updateNodes

  ###
  Listen to events of new sensor observations being added to this collection.
  When they are added, group them to individual nodes by adding to @nodes
  ###
  updateNodes: (m) ->
    @nodes.add @registry.byAddress m.get 'address'
    @nodes.get(m.get 'address').addObservation m

  ###
  Repeatedly poll the server for more date after a given interval
  ###
  poll: (after = 5000) -> @more().always =>_.delay (=> @poll after), after

  ###
  Get the latest set of data from the end point
  ###
  more: -> @fetch remove: false, data: since: @last()?.get 'timestamp'

  ###
  Fetch some sensor observation data for a particular date. The rest api will
  only return 24 hours worth of data, so this will only fill up a single day
  ###
  since: (date) -> @fetch data: since: date.toISOString()