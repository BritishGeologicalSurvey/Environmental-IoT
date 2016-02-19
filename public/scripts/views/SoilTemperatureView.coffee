define [
  'backbone'
  'cs!views/ChartView'
], (Backbone, ChartView)-> ChartView.extend
  
  el: '#soil-temperature-chart'

  sensors: [
      'field':'soil_temp_1', 'title':'Deep'
    ,
      'field':'soil_temp_2', 'title':'Surface'
    ,
      'field':'soil_temp_3', 'title':'Shallow'
  ]
