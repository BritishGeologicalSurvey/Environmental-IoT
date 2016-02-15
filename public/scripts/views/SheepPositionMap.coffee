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

  ###
  Add a marker for the newly detected node. 
  ###
  addMarker: (node) ->
    marker = @getMarker(node).addTo @markers

    node.observations.on 'add', (obs) =>
      marker.setLatLng obs.pick 'lat', 'lon'
      do @fitBounds

  ###
  Create a sheep marker for the given node. This will use the icon as defined 
  in the node registry
  ###
  getMarker: (node) -> L.marker [0,0], 
      title: node.id
      icon: L.icon
        iconUrl:     node.get 'icon'
        iconSize:    [50, 50]
        iconAnchor:  [50, 50]
        popupAnchor: [-15, -30]