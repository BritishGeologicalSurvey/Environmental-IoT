var SiteSensorLocationMap;
var siteSensorLayerLabels;

var sensorIcon = L.icon({
  iconUrl: '../../img/sensorIcon.png',
  iconSize: [30, 30],
  iconAnchor: [30, 30],
  popupAnchor: [-15, -30]
});

$(function() {
  SiteLocationMap.initMap();
  SiteLocationMap.addSensorData();
});

var SiteLocationMap = {

  initMap: function() {
    SiteSensorLocationMap = L.map('sensorLocationsMap').setView(startLocation, 18);
    L.esri.basemapLayer('Imagery').addTo(SiteSensorLocationMap);
  },
  addSensorData: function() {
    for (var i = 0; i < siteSensorPoints.length; i++) {
      marker = new L.marker([siteSensorPoints[i][1], siteSensorPoints[i][2]], {
          title: siteSensorPoints[i][0],
          icon: sensorIcon
        })
        .bindPopup('<p>Sensor: ' + siteSensorPoints[i][0] + '<br/><a href="#" onclick="OpsSensorModulesList.getSensorModules();return false;">View Sensor Modules</a></p>')
        .addTo(SiteSensorLocationMap)
        .on("click", function(e) {});
    }
  },

  setBasemap: function(basemap) {
    var layer = L.esri.basemapLayer(basemap);

    if (layer) {
      SiteSensorLocationMap.removeLayer(layer);
    }

    SiteSensorLocationMap.addLayer(layer);

    if (siteSensorLayerLabels) {
      SiteSensorLocationMap.removeLayer(siteSensorLayerLabels);
    }

    if (basemap === 'ShadedRelief' || basemap === 'Oceans' || basemap === 'Gray' || basemap === 'DarkGray' || basemap === 'Imagery' || basemap === 'Terrain') {
      siteSensorLayerLabels = L.esri.basemapLayer(basemap + 'Labels');
      SiteSensorLocationMap.addLayer(siteSensorLayerLabels);
    }
  },

  changeBasemap: function(basemaps) {
    var basemap = basemaps.value;
    SiteLocationMap.setBasemap(basemap);
  }

};
