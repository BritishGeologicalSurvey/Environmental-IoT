define [
  'backbone'
  'cs!models/Node'
], (Backbone, Node)-> Backbone.Collection.extend
  model: Node