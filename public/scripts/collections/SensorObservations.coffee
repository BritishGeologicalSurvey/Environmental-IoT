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
    @nodes.get(m.get 'address').observations.add m

  ###
  Repeatedly poll the server for more date after a given interval
  ###
  poll: (after = 5000) -> @more().always =>_.delay (=> @poll after), after

  ###
  Get the latest set of data from the end point
  ###
  more: -> @fetch remove: false, data: since: @last()?.get 'timestamp'