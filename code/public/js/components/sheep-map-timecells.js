$(function () {
  SheepTimeInCellsMap.initMap();
});

var SheepTimeInCellsMap = {

  initMap: function(message) {
    var sheepTimeCellsMap = L.map('sheepTimeCellsMap').setView(startLocation, 16);
    L.esri.basemapLayer('Imagery').addTo(sheepTimeCellsMap);
  }

};
