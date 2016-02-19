define [
  'backbone'
  'cs!views/ChartView'
], (Backbone, ChartView)-> ChartView.extend
  
  el: '#temperature-chart'

  sensors: [
      'field':'airtemp_c', 'title':'Temperature (C)'
  ]
