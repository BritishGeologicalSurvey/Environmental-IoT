define [
  'jquery'
  'backbone'
], ($, Backbone)-> Backbone.View.extend
  el: '#nodeStatus'

  initialize: (options) ->
    @type = options.type
    @nodeRegistry = options.nodeRegistry

    @listenTo @nodeRegistry, 'sync', @refresh
    @listenTo @collection, 'add', @refresh

  ###
  Update the display of how many nodes are online over how many are known about
  ###
  refresh: ->
    online = @collection.length
    known = @nodeRegistry.where(node_type: @type).length
    console.log "Updating node status now"
    @$('h3').html "#{online} / #{known}"
