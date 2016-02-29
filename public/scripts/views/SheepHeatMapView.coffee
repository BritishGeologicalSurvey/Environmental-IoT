define [
  'jquery'
  'backbone'
  'cs!views/DateFilteredMapView'
  'leaflet-heat'
], ($, Backbone, DateFilteredMapView) -> DateFilteredMapView.extend
  el: '#sheepHeatMapDiv'

  events: 
    'dp.show':   'updateTime' # In case we role in to another day
    'dp.change': 'selectTime'
  
  initialize:->
    DateFilteredMapView.prototype.initialize.apply this, arguments
    @liveHeatLayer = @createHeatMap(@model.sheep).addTo @leaflet.map

  ###
  Determine if the selected day is the today (in server time terms), if it is
  then show the live heatmap and show the live heat badge.
  ###
  selectTime: (evt) ->
    useLive = evt.date.isSame @model.clock.getTime(), 'day'

    @leaflet.map.removeLayer @historicHeatLayer if @historicHeatLayer?

    if useLive
      @$('.live').show()
      @leaflet.map.addLayer @liveHeatLayer
      @leaflet.fitBounds @liveHeatLayer
    else
      @$('.live').hide()
      @leaflet.map.removeLayer @liveHeatLayer
      @loadHistoricHeatLayer evt.date.toDate()

  ###
  Request the sheep collection from the @model for a particular date. 
  Show the loading overlay whilst loading commences
  ###
  loadHistoricHeatLayer: (date) ->
    historicSheep = @model.createSheep()
    @historicHeatLayer = @createHeatMap(historicSheep)
    @leaflet.map.addLayer @historicHeatLayer
    historicSheep.since(date)

  ###
  Create a leaflet heat map layer which is bound to a sheep collection. When
  observations are added to it, add these to the HeatLayer.
  ###
  createHeatMap: (sheep) ->
    heatmap = L.heatLayer([], max: 3)
    heatmap.getBounds =-> new L.LatLngBounds heatmap._latlngs
    
    sheep.on 'add', (obs) -> 
      lat = obs.get 'lat'
      lon = obs.get 'lon'
      heatmap.addLatLng [lat, lon] if lat? and lon?

    # Show the loading overlay and, remove once we have got some data
    do @showOverlay
    sheep.once 'sync', => 
      do @hideOverlay
      @leaflet.fitBounds heatmap

    return heatmap 
