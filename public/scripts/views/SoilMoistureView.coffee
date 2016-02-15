define [
  'jquery'
  'backbone'
  'amcharts'
  'amstock'
], ($, Backbone, amcharts)-> Backbone.View.extend
  el: '#soil-moisture-chart'
  
  initialize:->
    console.log do @chartSettings
    console.log amcharts
    @chart = amcharts.makeChart @el, @chartSettings()

    # @listenTo @collection, 'add', @updateChart

  # updateChart: ->
  #   console.log 'update chart'

  chartSettings: ->
    categoryAxesSettings:
      minPeriod: 'mm'
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
