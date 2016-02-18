define [
  'backbone'
  'cs!views/SoilChartView'
], (Backbone, SoilChartView)-> SoilChartView.extend

  el: '#soil-moisture-chart'

  sensors: [
      'field':'soil_moisture_1', 'title':'Deep'
    ,
      'field':'soil_moisture_2', 'title':'Surface'
    ,
      'field':'soil_moisture_3', 'title':'Shallow'
  ]
