define [
  'jquery'
  'backbone'
], ($, Backbone)-> Backbone.View.extend
  el: '#nodeStatus'
  initialize: ->
    @listenTo @model.nodeRegistry, 'add', @refresh
    @listenTo @model.soil.nodes, 'add', @refresh

  ###
  Update the display of how many nodes are online over how many are known about
  ###
  refresh: ->
    online = @model.soil.nodes.length
    known = @model.nodeRegistry.where(node_type:'Soil').length

    @$('h3').html "#{online} / #{known}"