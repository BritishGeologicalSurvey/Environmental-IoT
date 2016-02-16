define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'leaflet'
  'leaflet-heat'
  'bootstrap-datetimepicker'
], ($, Backbone, LeafletMapView, L) -> Backbone.View.extend
  el: '#sheepHeatMapDiv'
  
  initialize:->
    @leaflet = new LeafletMapView el: '#sheepHeatMap'

    @listenTo @collection, 'add', @addObservation
    @heatLayer = L.heatLayer([]).addTo @leaflet.map


    @$('.date').datetimepicker format: 'YYYY-MM-DD'
    
  addObservation: (obs) ->
    lat = obs.get 'lat'
    lon = obs.get 'lon'
    if lat? and lon?
      @heatLayer.addLatLng [lat, lon]