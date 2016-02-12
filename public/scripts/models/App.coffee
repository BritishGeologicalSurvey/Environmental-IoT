define [
  "backbone"
  "cs!collections/Sheep"
  "cs!collections/Nodes"
], (Backbone, Sheep, Nodes)-> Backbone.Model.extend
  
  initialize: ->
    @sheepNodes = new Nodes

    @sheep = new Sheep
    @listenTo @sheep, 'add', @updateSheepNodes
    do @sheep.poll # Start repeated listening

  ###
  Listen to events triggered by the sheep observations and allocate to 
  individual sheep nodes
  ###
  updateSheepNodes: (m) ->
    @sheepNodes.add id: m.get 'address'
    @sheepNodes.get(m.get 'address').observations.add m
