define [
  'underscore'
  'jquery'
  'backbone'
  'tpl!templates/SensorDetails.tpl'
  'sparkline'
], (_, $, Backbone, template)-> Backbone.View.extend
  el: '#opsSensorModuleListDiv'

  fields: [
    { key: 'rssi',             label: 'RSSI' }
    { key: 'air_temp_1',       label: 'Air Temperature 1' }
    { key: 'air_temp_2',       label: 'Air Temperature 2' }
    { key: 'air_temp_3',       label: 'Air Temperature 3' }
    { key: 'air_humidity_1',   label: 'Air Humidity 1' }
    { key: 'air_humidity_2',   label: 'Air Humidity 2' }
    { key: 'air_humidity_3',   label: 'Air Humidity 3' }
    { key: 'soil_temp_1',      label: 'Soil Temperature 1' }
    { key: 'soil_temp_2',      label: 'Soil Temperature 2' }
    { key: 'soil_temp_3',      label: 'Soil Temperature 3' }
    { key: 'soil_moisture_1',  label: 'Soil Moisture 1' }
    { key: 'soil_moisture_2',  label: 'Soil Moisture 2' }
    { key: 'soil_moisture_3',  label: 'Soil Moisture 3' }
  ]

  initialize: ->
    @listenTo @model.observations, 'add', @refresh
    
  refresh:->
    data = _.map @fields, (f) =>
      latest = _.filter @model.observations.pluck(f.key), (v) -> v

      label:    f.label
      latest:   _.last latest
      previous: _.last latest, 7
    @$el.html template 
      data:    data
      id:      @model.id
      updated: @model.observations.last().get 'timestamp'

    @$('.sparkbar').sparkline 'html', type: 'bar'
  