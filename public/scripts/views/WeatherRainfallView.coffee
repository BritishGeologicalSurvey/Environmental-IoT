define [
  'backbone'
  'cs!views/ChartView'
], (Backbone, ChartView)-> ChartView.extend
  
  el: '#rainfall-chart'

  sensors: [
      'field':'rain_mm', 'title':'Rainfall (mm)'
  ]
