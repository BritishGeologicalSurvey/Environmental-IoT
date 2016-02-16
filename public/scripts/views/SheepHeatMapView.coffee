define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'leaflet'
  'leaflet-heat'
], ($, Backbone, LeafletMapView, L) -> LeafletMapView.extend
  el: '#sheepHeatMap'
  
  initialize:->
    LeafletMapView.prototype.initialize.apply this, arguments

    @listenTo @collection, 'add', @addObservation
    @heatLayer = L.heatLayer([]).addTo @map

  addObservation: (obs) ->
    lat = obs.get 'lat'
    lon = obs.get 'lon'
    if lat? and lon?
      @heatLayer.addLatLng [lat, lon]