define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'cs!views/SensorDetailsView'
  'leaflet'
], ($, Backbone, LeafletMapView, SensorDetailsView, L) -> LeafletMapView.extend
  el: '#sensorLocationsMap'

  events:
    'click .leaflet-popup a': 'clicked'

  initialize: ->
    @icon = L.icon
      iconUrl:     '/img/sensorIcon.png'
      iconSize:    [30, 30]
      iconAnchor:  [30, 30]
      popupAnchor: [-15, -30]

    LeafletMapView.prototype.initialize.apply this, arguments

    @listenTo @collection, 'add', @addMarker

  ###
  Add a marker for the sensors which are online. If the lat,lon is not known 
  then we can not create a marker for it.
  ###
  addMarker: (node) ->
    if node.has('lat') and node.has('lon')
      L.marker( node.pick('lat', 'lon'), title: node.id, icon: @icon )
      .bindPopup("""
        <p>Sensor: #{node.id}<br/>
        <a node='#{node.id}'>View Sensor Modules</a></p>
      """)
      .addTo @markers
      @fitBounds @markers
  
  ###
  Event handler for <a> clicks in leaflet popups. Open a detailed sensor view
  for the selected sensor. Remove any old ones which might exists
  ###
  clicked: (evt) ->
    do detailView?.stopListening
    detailView = new SensorDetailsView 
      model: @collection.get $(evt.target).attr 'node'
    do evt.preventDefault