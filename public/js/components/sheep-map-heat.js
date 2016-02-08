var sheepHeatMap;
var sheepHeatMapDataLayer;

$(function () {
  SheepPositionHeatMap.initMap();
});

var SheepPositionHeatMap = {

  initMap: function(message) {
    sheepHeatMap = L.map('sheepHeatMap').setView(startLocation, 16);
    L.esri.basemapLayer('Imagery').addTo(sheepHeatMap);
  },

  loadSpecificData: function(startDateInput) {
    var startDateFromCalendar = new Date(startDateInput);
    var nextDay = new Date(startDateFromCalendar);
    var dateValue = nextDay.getDate() + 1;
    nextDay.setDate(dateValue);

    var startDateIsoString = startDateFromCalendar.toISOString();
    var endDateIsoString = nextDay.toISOString();

    $.getJSON("/api?sensor=gps&starttime="+startDateIsoString+"&endtime="+endDateIsoString, function(result) {
      if (result.length == 0) {
        console.log("No data");
        if (!sheepHeatMapDataLayer){
        }
        else {
          sheepHeatMap.removeLayer(sheepHeatMapDataLayer);
          $("#sheepHeatMapOverlay").fadeOut(300, function() { $("#sheepHeatMapOverlay").remove(); });
          $('#sheepHeatStatusText').html("No data found.");
        }
      }
      if (result.length) {
        if (!sheepHeatMapDataLayer){
        }
        else {
          sheepHeatMap.removeLayer(sheepHeatMapDataLayer);
        }
        var cleanData = [];
        for (var i = 0; i < result.length; i++) {
          cleanData.push([result[i].lat, result[i].lon, "0.01"]);
        }
        sheepHeatMapDataLayer = L.heatLayer(cleanData).addTo(sheepHeatMap);
        $("#sheepHeatMapOverlay").fadeOut(300, function() { $("#sheepHeatMapOverlay").remove(); });
        $('#sheepHeatStatusText').html("");
      }
    }).fail(function(jqxhr, textStatus, error) {
      var err = textStatus + ", " + error;
      console.log("Request Failed: " + err)
    });
  }
};
