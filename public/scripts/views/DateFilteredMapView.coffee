define [
  'backbone'
  'cs!views/LeafletMapView'
  'bootstrap-datetimepicker'
], (Backbone, LeafletMapView)-> Backbone.View.extend 
  initialize:->
    @leaflet = new LeafletMapView el: @$('.map')[0]
    @time = @$('.date').datetimepicker format:'YYYY-MM-DD'
    @listenTo @model.clock, 'sync', @updateTime

  ###
  Fade the loading overlay in
  ###
  showOverlay: -> @$('.overlay').fadeIn 300

  ###
  Fade the loading overlay out
  ###
  hideOverlay: -> @$('.overlay').fadeOut 300

  ###
  Set the max date for the DateTimePicker. 
  ###
  updateTime: ->
    now = @model.clock.getTime()
    now.setHours 0,0,0,0 # Move this time to midnight
    @time.data('DateTimePicker').maxDate now