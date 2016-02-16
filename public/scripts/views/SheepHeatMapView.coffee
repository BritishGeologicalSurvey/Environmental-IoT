define [
  'jquery'
  'backbone'
  'cs!views/LeafletMapView'
  'leaflet-heat'
  'bootstrap-datetimepicker'
], ($, Backbone, LeafletMapView) -> Backbone.View.extend
  el: '#sheepHeatMapDiv'

  events: 
    'dp.show':   'updateTime' # In case we role in to another day
    'dp.change': 'selectTime'
  
  initialize:->
    @leaflet = new LeafletMapView el: '#sheepHeatMap'
    @liveHeatLayer = @createHeatMap(@model.sheep).addTo @leaflet.map
    @time = @$('.date').datetimepicker format:'YYYY-MM-DD'

    @listenTo @model.clock, 'sync', @updateTime

  ###
  Determine if the selected day is the today (in server time terms), if it is
  then show the live heatmap and show the live heat badge.
  ###
  selectTime: (evt) ->
    useLive = evt.date.isSame @model.clock.getTime(), 'day'

    @leaflet.map.removeLayer @historicHeatLayer if @historicHeatLayer?

    if useLive
      @$('.badge').show()
      @leaflet.map.addLayer @liveHeatLayer
    else
      @$('.badge').hide()
      @leaflet.map.removeLayer @liveHeatLayer
      @loadHistoricHeatLayer evt.date.toDate()

  ###
  Request the sheep collection from the @model for a particular date. 
  Show the loading overlay whilst loading commences
  ###
  loadHistoricHeatLayer: (date) ->
    do @showOverlay
    historicSheep = @model.createSheep()
    @historicHeatLayer = @createHeatMap(historicSheep)
    @leaflet.map.addLayer @historicHeatLayer
    historicSheep.since(date).complete => @hideOverlay()

  ###
  Fade the loading overlay in
  ###
  showOverlay: -> @$('#sheepHeatMapOverlay').fadeIn 300

  ###
  Fade the loading overlay out
  ###
  hideOverlay: -> @$('#sheepHeatMapOverlay').fadeOut 300

  ###
  Create a leaflet heat map layer which is bound to a sheep collection. When
  observations are added to it, add these to the HeatLayer.
  ###
  createHeatMap: (sheep) ->
    heatmap = L.heatLayer([])
    sheep.on 'add', (obs) -> 
      lat = obs.get 'lat'
      lon = obs.get 'lon'
      heatmap.addLatLng [lat, lon] if lat? and lon?
    return heatmap

  ###
  Set the max date for the DateTimePicker. 
  ###
  updateTime: ->
    @time.data('DateTimePicker').maxDate @model.clock.getTime()
