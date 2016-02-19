define [
  'jquery'
  'backbone'
  'leaflet'
], ($, Backbone, L)-> Backbone.View.extend 
  initialize:->
    @map = L.map(@el).setView [53.4, -1.8], 6

    osm = L.tileLayer '//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'

    osm.addTo @map
    
    @nodata = $('<span class="nodata badge bg-yellow">No Data</span>').appendTo(@$el)
    @markers = L.featureGroup([]).addTo @map

  ###
  Zoom in to the bounds of a given layer. If the bounds is not valid 
  (e.g. generated from a layer with no points) then show the nodata badge
  ###
  fitBounds: (layer) ->
    bounds = layer.getBounds()
    if bounds.isValid()
      @map.fitBounds bounds
      do @nodata.hide
    else
      do @nodata.show