$(function () {
  SheepCurrentPositionMap.initMap();
});

var SheepCurrentPositionMap = {

  initMap: function(message) {
    var sheepPositionMap = L.map('sheepPositionMap').setView(startLocation, 16);
    L.esri.basemapLayer('Imagery').addTo(sheepPositionMap);
  }

};
