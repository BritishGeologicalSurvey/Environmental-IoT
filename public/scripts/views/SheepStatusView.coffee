define [
  'jquery'
  'backbone'
  'tpl!templates/SheepStatus.tpl'
], ($, Backbone, template) -> Backbone.View.extend
  el: '#sheepStatus'
  
  initialize: ->
    @listenTo @model.nodeRegistry, 'sync', @render
    @listenTo @model.sheep.nodes, 'change:latest', @update

  update: (sheep) ->
    @$(".update-#{sheep.getAddress()}").html sheep.get('latest').get 'timestamp'

  render: ->
    @$el.html template nodes: @model.nodeRegistry.where node_type:'Sheep'