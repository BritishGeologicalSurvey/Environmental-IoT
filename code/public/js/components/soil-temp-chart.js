
  AmCharts.ready(function () {
    //SoilTempChart.reloadData("/querynode?nodeid=A6&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1");
    //SoilMoistureChart.createStockChart();
  });

var SoilTempChart = {

    chart: {},

    reloadData: function(url) {
      //var url = "http://localhost:3000/querynode?nodeid=A6&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1";
      SoilTempChart.createStockChart();

      $.getJSON(url)
        .done(function(data) {
          SoilTempChart.refreshChartData(data);
      });
    },

    refreshChartData: function(myData)
    {
      var sensors = ["soil_temp_1", "soil_temp_2", "soil_temp_3"];
      sensors.forEach(function(sensor) {
        console.log('Adding.. ' + sensor);
        SoilTempChart.chart.dataSets.push({
          dataProvider: myData,
          title: sensor,
          fieldMappings: [{
            fromField: sensor,
            toField: "value"
          }],
          categoryField: "timestamp",
          compared: true,
        });
      });
      SoilTempChart.chart.validateData();
    },

    createStockChart: function() {

      SoilTempChart.chart = AmCharts.makeChart("soil-temp-chart", {
        categoryAxesSettings: {
          minPeriod: "mm",
          groupToPeriods: ["mm", "10mm", "30mm", "hh"],
          maxSeries: 100,
        },
        panelsSettings: {
          recalculateToPercents: "never",
        },
        //dataDateFormat: "YYYY-MM-DDTJJ:NN:SS.QQQZ",
        type: "stock",
        panels: [{

          showCategoryAxis: true,
          title: "",
          percentHeight: 70,

          stockGraphs: [{
            id: "g1",
            type: "smoothedLine",
            valueField: "value",
            comparable: true,
            compareField: "value",
            bullet: "round",
            bulletBorderColor: "#FFFFFF",
            bulletBorderAlpha: 0.8,
            bulletBorderThickness: 2,
            bulletSize: 6,
            balloonText: "[[title]]:<b>[[value]]</b>",
            compareGraphType: "smoothedLine",
            compareGraphBalloonText: "[[title]]:<b>[[value]]</b>",
            compareGraphBullet: "round",
            compareGraphBulletBorderColor: "#FFFFFF",
            compareGraphBulletBorderAlpha: 0.8,
            compareGraphBulletBorderThickness: 2,
            compareGraphBulletSize: 6,
          }],

          stockLegend: {
            periodValueTextRegular: "[[value]]",
          },

        }],

        chartScrollbarSettings: {
          graph: "g1",
          updateOnReleaseOnly: true,
          position: "top",
        },

        chartCursorSettings: {
          valueBalloonsEnabled: true,
          valueLineEnabled:true,
          valueLineBalloonEnabled:true
        },

      });
    }
};
