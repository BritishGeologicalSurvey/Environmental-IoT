define [
  'jquery'
  'backbone'
  'leaflet'
], ($, Backbone, L)-> Backbone.View.extend
  el: '#sheepPositionMap'
  
  initialize:->
    @map = L.map(@el).setView [53.4, -1.8], 6

    osm = L.tileLayer '//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'

    osm.addTo @map
    
    @listenTo @collection, 'add', @addMarker

  addMarker: (node) ->
    marker = L.marker([0,0]).addTo(@map)

    node.observations.on 'add', (obs) ->
      marker.setLatLng obs.pick 'lat', 'lon'