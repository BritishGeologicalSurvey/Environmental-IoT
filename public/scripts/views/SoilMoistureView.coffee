define [
  'underscore'
  'jquery'
  'backbone'
  'amcharts'
  'amstock'
], (_, $, Backbone, amcharts)-> Backbone.View.extend
  el: '#soil-moisture-chart'

  sensors: [
      'field':'soil_moisture_1', 'title':'Deep'
    ,
      'field':'soil_moisture_2', 'title':'Surface'
    ,
      'field':'soil_moisture_3', 'title':'Shallow'
  ]

  initialize:->
    @chart = amcharts.makeChart @el, @chartSettings()
    @listenTo @collection, 'add', @updateChart

  ###
  Plot the moisture data for the currently selected node.  If no node has been selected then use
  the first one that data is recieved from.
  ###
  updateChart: (node) ->
    if not @nodeid?
      @nodeid = node.id

    if node.id == @nodeid
      node.observations.on 'add', (obs) =>
        sensorType = obs.get 'sensor'
        _.chain(@sensors).filter((f) -> obs.has(f.field) ).each (sensor) =>
          datasetTitle = node.id + " " + sensor.title
          dataProvider = _.findWhere(@chart.dataSets, {'title': datasetTitle})
          if not dataProvider
            @addToChart obs, node, datasetTitle, sensor
          else
            @endDate = new Date(obs.get('timestamp'))
            dataProvider.dataProvider.push obs.toJSON()
          do @chart.validateData
          @chart.zoom @startDate, @endDate

  ###
  Add a dataset to the chart
  ###
  addToChart: (obs, node, datasetTitle, sensor) ->
    @startDate = new Date(obs.get('timestamp'))
    @endDate = new Date(obs.get('timestamp'))
    @chart.dataSets.push
      dataProvider: do node.observations.toJSON
      title: datasetTitle
      fieldMappings: 
        [
          fromField: sensor.field
          toField: 'value'
        ]
      categoryField: 'timestamp'
      compared: true

  chartSettings: ->
    categoryAxesSettings:
      minPeriod: 'ss'
      groupToPeriods: [
        'mm'
        '10mm'
        '30mm'
        'hh'
      ]
      maxSeries: 100
    panelsSettings: recalculateToPercents: 'never'
    type: 'stock'
    panels: [ {
      showCategoryAxis: true
      title: ''
      percentHeight: 70
      stockGraphs: [ {
        id: 'g1'
        type: 'smoothedLine'
        valueField: 'value'
        comparable: true
        compareField: 'value'
        bullet: 'round'
        bulletBorderColor: '#FFFFFF'
        bulletBorderAlpha: 0.8
        bulletBorderThickness: 2
        bulletSize: 6
        balloonText: '[[title]]:<b>[[value]]</b>'
        compareGraphType: 'smoothedLine'
        compareGraphBalloonText: '[[title]]:<b>[[value]]</b>'
        compareGraphBullet: 'round'
        compareGraphBulletBorderColor: '#FFFFFF'
        compareGraphBulletBorderAlpha: 0.8
        compareGraphBulletBorderThickness: 2
        compareGraphBulletSize: 6
      } ]
      stockLegend: periodValueTextRegular: '[[value]]'
    } ]
    chartScrollbarSettings:
      graph: 'g1'
      updateOnReleaseOnly: true
      position: 'top'
    chartCursorSettings:
      valueBalloonsEnabled: true
      valueLineEnabled: true
      valueLineBalloonEnabled: true
