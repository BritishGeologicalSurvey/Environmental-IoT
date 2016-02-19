define [
  'backbone'
  'cs!views/ChartView'
], (Backbone, ChartView)-> ChartView.extend
  
  el: '#wind-speed-chart'

  sensors: [
      'field':'windspeed_ms', 'title':'Wind Speed (ms)'
  ]
