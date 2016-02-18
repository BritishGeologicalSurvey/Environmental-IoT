define [
  'underscore'
  'backbone'
  'cs!models/Node'
], (_, Backbone, Node)-> Backbone.Collection.extend
  url: '/nodes'

  model: Node

  ###
  Locate the sensor node specified by the given addess.
  ###
  byAddress: (address) ->
    node = @find (n) -> n.getAddress() is address
  
    return _.defaults id: address, node?.attributes
