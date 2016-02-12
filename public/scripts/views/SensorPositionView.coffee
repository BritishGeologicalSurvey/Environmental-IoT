define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'leaflet'
], ($, Backbone, LeafletMapView, L) -> LeafletMapView.extend
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

    @listenTo @model, 'add', @addMarker

  addMarker: (node) ->
    if node.has('lat') and node.has('lon')
      L.marker( node.pick('lat', 'lon'), title: node.id, icon: @icon )
      .bindPopup(
        "<p>Sensor: #{node.id}<br/><a href='#'>View Sensor Modules</a></p>"
      )
      .addTo @map

  clicked: (evt) ->

    do evt.preventDefault