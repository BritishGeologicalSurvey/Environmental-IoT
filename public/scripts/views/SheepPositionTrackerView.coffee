define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'bootstrap-datetimepicker'
], ($, Backbone, LeafletMapView) -> Backbone.View.extend
  el: '#sheepPositionTracersDiv'

  initialize: ->
    @leaflet = new LeafletMapView el: '#sheepTraceMap'

    @listenTo @model.nodeRegistry, 'sync', @renderDropDown

  renderDropDown: ->
    dropdown = @$('#sheepTrackSelectSheepId')
    sheep = @model.nodeRegistry.where(node_type: 'Sheep')

    dropdown.append _.map sheep, (s) -> "<option>#{s.getAddress()}</option>"