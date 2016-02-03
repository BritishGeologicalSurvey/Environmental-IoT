var sheepTraceMap;
var storedSheepLine = [];
var sheepTracePoll;

$(function() {
  SheepTraceChart.initMap();
});

var SheepTraceChart = {

  initMap: function(message) {
    sheepTraceMap = L.map('sheepTraceMap').setView(startLocation, 16);
    L.esri.basemapLayer('Topographic').addTo(sheepTraceMap);
  },

  addPointsToMap: function(data, lineColour) {
    SheepTraceChart.clearMap();
    for (var i = 0; i < data.length; i++) {
      storedSheepLine.push([data[i].lat, data[i].lon]);
    }

    var polyline = L.polyline(storedSheepLine, {
      color: 'red',
      smoothFactor: 0.1,
      weight: 3,
      opacity: 1,
      lineJoin: 'round'
    }).addTo(sheepTraceMap);

    sheepTraceMap.fitBounds(polyline.getBounds());
  },

  // '0xd3','2015-12-01T08:00:00.657Z','2015-12-01T09:00:00.657Z'
  pollData: function(sheepId, startTime, updateFreq, timePeriod) {
    var sheepTimePeriod = timePeriod*1000;
    var sheepUpdateFreq = updateFreq*1000;
    var startDate = new Date(startTime);
    var newEndDate = new Date(startDate.getTime() + sheepTimePeriod);

    var startDateIsoString = startDate.toISOString();
    var endDateIsoString = newEndDate.toISOString();
    var prettyEndString = new Date(endDateIsoString)
    if ($('#SheepButton1').text() == "Stop")
    {
      sheepTracePoll = $.ajax({
          url: "/querynode?nodeid=" + sheepId + "&starttime=" + startDateIsoString + "&endtime=" + endDateIsoString,
          type: "GET",
          success: function(data) {
            if (data.length == 0)
            {
              // no new data
            }
            if (data.length)
            {
              SheepTraceChart.addPointsToMap(data, SheepTraceChart.getRandomColor());
              var updateText = ("Last Updated: " + prettyEndString + ". Params: " + sheepId + ", " + updateFreq + "," +timePeriod);
              $('#sheepTrackStatusBar').html(updateText);
            }
          },
          dataType: "json",
          complete: setTimeout(function() {SheepTraceChart.pollData(sheepId, endDateIsoString, updateFreq, timePeriod)}, sheepUpdateFreq)
      })
    }
    else
    {
      $('#sheepTrackStatusBar').html("Stopped updating.");
    }

  },



  loadSpecificData: function(sheepId, startTime, endTime) {

    $.getJSON("/querynode?nodeid=" + sheepId + "&starttime=" + startTime + "&endtime=" + endTime, function(result) {
      if (result.length == 0) {
        console.log("No data");
      }
      if (result.length) {
        SheepTraceChart.clearMap();
        SheepTraceChart.addPointsToMap(result, SheepTraceChart.getRandomColor());
      }
    }).fail(function(jqxhr, textStatus, error) {
      var err = textStatus + ", " + error;
      console.log("Request Failed: " + err)
    });

  },

  getRandomColor: function() {
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++) {
      color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
  },

  clearMap: function() {
    for (i in sheepTraceMap._layers) {
      if (sheepTraceMap._layers[i]._path != undefined) {
        try {
          sheepTraceMap.removeLayer(sheepTraceMap._layers[i]);
        } catch (e) {
          console.log("problem with " + e + sheepTraceMap._layers[i]);
        }
      }
    }
  }


};
