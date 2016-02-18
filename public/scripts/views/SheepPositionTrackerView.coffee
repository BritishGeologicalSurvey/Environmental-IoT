define [
  'underscore'
  'jquery'
  'backbone'
  'cs!views/DateFilteredMapView'
], (_, $, Backbone, DateFilteredMapView) -> DateFilteredMapView.extend
  el: '#sheepPositionTracersDiv'
  
  events: 
    'dp.show':   'updateTime' # In case we role in to another day
    'dp.change': 'selectTime'
  
  initialize:->
    DateFilteredMapView.prototype.initialize.apply this, arguments

  selectTime: ->
    do @showOverlay
    @leaflet.map.removeLayer @traces if @traces?
    sheep = @model.createSheep()
    sheep
      .since(@time.data('DateTimePicker').date().toDate())
      .complete =>
        @traces = L.featureGroup @createSheepTraces sheep.nodes
        @traces.addTo @leaflet.map
        @leaflet.fitBounds @traces
        do @hideOverlay

  createSheepTraces: (nodes) ->
    nodes.map (n) =>
      points = n.observations.map( (obs) => [obs.get('lat'), obs.get('lon')] )
      return @createSheepTrace points, n.get 'colour'

  createSheepTrace: (points, colour) ->
    L.polyline points,
      color:        colour
      smoothFactor: 0.1
      weight:       3
      opacity:      1
      lineJoin:    'round'
