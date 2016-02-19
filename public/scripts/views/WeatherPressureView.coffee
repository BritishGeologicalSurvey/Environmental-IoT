define [
  'backbone'
  'cs!views/ChartView'
], (Backbone, ChartView)-> ChartView.extend
  
  el: '#pressure-chart'

  sensors: [
      'field':'pressure_hpa', 'title':'Pressure (hPa)'
  ]
