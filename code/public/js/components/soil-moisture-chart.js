  AmCharts.ready(function () {
    SoilMoistureChart.reloadData("/querynode?nodeid=A6&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1", "A6", false);
  });

var SoilMoistureChart = {

    chart: {},

    reloadData: function(url, sensor, addToExisting) {
      //var url = "http://localhost:3000/querynode?nodeid=A6&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1";
      if (!addToExisting)
      {
        SoilMoistureChart.createStockChart();
      }

      $.getJSON(url)
        .done(function(data) {
          SoilMoistureChart.refreshChartData(sensor, data);
      });
    },

    refreshChartData: function(sensorId, myData)
    {
      var sensors = [
        {"field":"soil_moisture_1", "title":"Deep"},
        {"field":"soil_moisture_2", "title":"Surface"},
        {"field":"soil_moisture_3", "title":"Shallow"}
      ];
      sensors.forEach(function(sensor) {
        console.log('Adding.. ' + sensor);
        SoilMoistureChart.chart.dataSets.push({
          dataProvider: myData,
          title: sensorId + ' ' + sensor.title,
          fieldMappings: [{
            fromField: sensor.field,
            toField: "value"
          }],
          categoryField: "timestamp",
          compared: true,
        });
      });
      SoilMoistureChart.chart.validateData();
    },

    createStockChart: function() {

      SoilMoistureChart.chart = AmCharts.makeChart("soil-moisture-chart", {
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
