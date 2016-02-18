define [
  'underscore'
  'jquery'
  'backbone'
  'amcharts'
  'amstock'
], (_, $, Backbone, amcharts) -> Backbone.View.extend

  initialize: ->
    @chart = amcharts.makeChart @el, @chartSettings()
    @initializeChart @model
    @listenTo @model, 'add', @addObservation

  initializeChart: (node) ->
    @nodeId = node.id
    node.observations.each (obs) =>
      @startDate = new Date(obs.get('timestamp')) if not @startDate?
      @addObservation obs
    node.observations.on 'add', (obs) => @addObservation obs

  ###
  Add a single observation to the chart, displaying only measurements from the defined list of sensors (eg moisture_1, moisture_2, etc).
  If the chart does not yet contain measurements for a specific sensor then add a dataset to display that sensor.
  ###
  addObservation: (obs) ->
    _.chain(@sensors).filter((f) -> obs.has(f.field) ).each (sensor) =>
      @endDate = new Date(obs.get('timestamp'))
      datasetTitle = @nodeId + " " + sensor.title
      dataProvider = _.findWhere(@chart.dataSets, {'title': datasetTitle})
      if not dataProvider
        @addDataset obs, datasetTitle, sensor
      else
        dataProvider.dataProvider.push obs.toJSON()
    do @chart.validateData
    @chart.zoom @startDate, @endDate

  ###
  Add a dataset to the chart, a dataset is used to hold observations for a specific sensor
  ###
  addDataset: (obs, datasetTitle, sensor) ->
    @chart.dataSets.push
      dataProvider: [obs.toJSON()]
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
