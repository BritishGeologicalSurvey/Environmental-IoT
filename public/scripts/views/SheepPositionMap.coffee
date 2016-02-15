define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'leaflet'
], ($, Backbone, LeafletMapView, L) -> LeafletMapView.extend
  el: '#sheepPositionMap'
  
  initialize:->
    LeafletMapView.prototype.initialize.apply this, arguments
    
    @listenTo @collection, 'add', @addMarker

  addMarker: (node) ->
    marker = L.marker([0,0]).addTo @markers

    node.observations.on 'add', (obs) =>
      marker.setLatLng obs.pick 'lat', 'lon'
      do @fitBounds