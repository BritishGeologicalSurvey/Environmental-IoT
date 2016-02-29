define [
  'jquery'
  'backbone'
  'leaflet'
  'esri-leaflet'
], ($, Backbone, L)-> Backbone.View.extend 
  initialize:->
    @map = L.map(@el).setView [53.4, -1.8], 6

    esri = L.esri.basemapLayer 'Imagery'
    esri.addTo @map

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