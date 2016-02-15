define [
  'jquery'
  'backbone'
  'amcharts'
  'amstock'
], ($, Backbone, amcharts)-> Backbone.View.extend
  el: '#soil-moisture-chart'


  getData: ->
    [
      timestamp: "2015-12-04T11:28:17.946Z"
      temp: "8.4"
    ,
      timestamp: "2015-12-04T11:29:17.946Z"
      temp: "8.0"
    ,
      timestamp: "2015-12-04T11:30:17.946Z"
      temp: "8.9"
    ]

  
  initialize:->
    @chart = amcharts.makeChart @el, @chartSettings()
    @listenTo @collection, 'add', @updateChart
    # do @hardcoded


  hardcoded: ->
    console.log do @getData
    @chart.dataSets.push
      dataProvider: do @getData
      title: 'my chart'
      fieldMappings: 
        [
          fromField: 'temp',
          toField: 'value'
        ]
      categoryField: "timestamp"
      compared: true
    do @chart.validateData

  updateChart: (node) ->
    node.observations.on 'add', (obs) =>
      console.log node.id
      if node.id == 'AF'
        console.log do node.observations.toJSON
        sensor = "soil_1"
        title = node.id + " " + sensor
        dataProvider = _.findWhere(@chart.dataSets, {'title': title})
        if not dataProvider
          console.log 'adding'
          @chart.dataSets.push
            dataProvider: do node.observations.toJSON
            title: title
            fieldMappings: 
              [
                fromField: 'air_temp_1'
                toField: 'value'
              ]
            categoryField: 'timestamp'
            compared: true
        else
          if obs.get('air_temp_1')
            console.log 'updating'
            console.log obs.toJSON()
            console.log dataProvider.dataProvider
            dataProvider.dataProvider.push obs.toJSON()
          else
            console.log 'attribute not found'
    do @chart.validateData


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
