var SoilSensorLocationMap;
var siteSensorLayerLabels;

$(function () {
  SoilLocationMap.initMap();
  SoilLocationMap.addSensorData();
});

var SoilLocationMap = {

  initMap: function() {
    SoilSensorLocationMap = L.map('soilLocationsMap').setView(startLocation, 18);
    L.esri.basemapLayer('Imagery').addTo(SoilSensorLocationMap);
  },

  addToCharts: function(sensor) {
    SoilMoistureChart.reloadData("/querynode?nodeid=" + sensor + "&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1", sensor, true);
    SoilTempChart.reloadData("/querynode?nodeid=" + sensor + "&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1", sensor, true);
  },

  reloadCharts: function(sensor) {
    SoilMoistureChart.reloadData("/querynode?nodeid=" + sensor + "&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1", sensor, false);
    SoilTempChart.reloadData("/querynode?nodeid=" + sensor + "&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z&packet=1", sensor, false);
  },

  addSensorData: function() {
    for (var i = 0; i < siteSensorPoints.length; i++) {
        var addToExistingOnClick = "SoilLocationMap.addToCharts('" + siteSensorPoints[i][0]  + "');return false;";
        var reloadChartOnClick = "SoilLocationMap.reloadCharts('" + siteSensorPoints[i][0]  + "');return false;";
        var popup = '<p>Sensor: ' + siteSensorPoints[i][0] + '<br/><a href="#" onclick="' + addToExistingOnClick + '">Add to Existing Charts</a><br/><a href="#" onclick="' + reloadChartOnClick + '">Create New Charts</a></p>'
        marker = new L.marker([siteSensorPoints[i][1],siteSensorPoints[i][2]], {title: siteSensorPoints[i][0]})
          //'<p>Sensor: ' + siteSensorPoints[i][0] + '<br/><a href="#" onclick="SoilLocationMap.reloadCharts("A0");return false;">Add to Existing Graph</a><br/><a id="myLink2" href="#">Update Graph</a></p>'
          .bindPopup(popup)
          .addTo(SoilSensorLocationMap)
          .on("click", function(e) {

          });

    }
  },

  setBasemap: function(basemap) {
      var layer = L.esri.basemapLayer(basemap);

      if (layer) {
        SoilSensorLocationMap.removeLayer(layer);
      }

      SoilSensorLocationMap.addLayer(layer);

      if (siteSensorLayerLabels) {
        SoilSensorLocationMap.removeLayer(siteSensorLayerLabels);
      }

      if (basemap === 'ShadedRelief'
       || basemap === 'Oceans'
       || basemap === 'Gray'
       || basemap === 'DarkGray'
       || basemap === 'Imagery'
       || basemap === 'Terrain'
     ) {
        siteSensorLayerLabels = L.esri.basemapLayer(basemap + 'Labels');
        SoilSensorLocationMap.addLayer(siteSensorLayerLabels);
      }
  },

  changeBasemap: function(basemaps){
    var basemap = basemaps.value;
    SoilLocationMap.setBasemap(basemap);
  }

};
