define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'cs!views/SoilMoistureView'
  'cs!views/SoilTemperatureView'
  'leaflet'
], ($, Backbone, LeafletMapView, SoilMoistureView, SoilTemperatureView, L) -> LeafletMapView.extend
  el: '#soilLocationsMap'

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
  then we can not create a marker for it.  Also don't add it if it is not a 
  soil moisture sensor
  ###
  addMarker: (node) ->
    if node.has('lat') and node.has('lon')
      L.marker( node.pick('lat', 'lon'), title: node.id, icon: @icon )
      .bindPopup("""
        <p>Sensor: #{node.id}<br/>
        <a node='#{node.id}' variable='moisture'>View Measurements</a></p>
      """)
      .addTo @markers
      @fitBounds @markers
  
  ###
  Event handler for <a> clicks in leaflet popups. Open a detailed sensor view
  for the selected sensor. Remove any old ones which might exists
  ###
  clicked: (evt) ->
    do @moistureView?.stopListening
    do @temperatureView?.stopListening
    @moistureView = new SoilMoistureView 
      model: @collection.get $(evt.target).attr 'node'
    @temperatureView = new SoilTemperatureView 
      model: @collection.get $(evt.target).attr 'node'
    do evt.preventDefault
