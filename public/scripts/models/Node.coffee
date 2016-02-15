define [
  "backbone"
], (Backbone)-> Backbone.Model.extend
  initialize: ->
    @observations = new Backbone.Collection

  ###
  Add an observation to this nodes observations collections. Keep track of the
  latest observation.
  ###
  addObservation: (obs) ->
    @observations.add obs
    @set latest: obs

  ###
  Read the address key as defined in the node registry to locate the address 
  field which is used by observation records
  ###
  getAddress: -> JSON.parse( @get 'address' )[0].address