define [
  'underscore'
  'backbone'
], (_, Backbone, Node)-> Backbone.Collection.extend
  url: '/nodes'

  ###
  Locate the sensor node specified by the given addess.
  ###
  byAddress: (address) ->
    node = @findWhere
      address: "[{\"interface-type\":\"XBEE\",\"address\":\"#{address}\"}]"
    
    return _.defaults id: address, node?.attributes
