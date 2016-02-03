$(function () {

});

var OpsSensorModulesList = {

  getSensorModules: function() {
    /*
    TODO: Need to build a REST query to the MogoDB which will:
      1) Find the pair of soil packets requested (live or archive data)
      2) Merge these two records together using their seq_id and sensor fields
      3) Store and use this object for display
    */
    $.getJSON("/querysoil?nodeid=A1&starttime=2015-12-11T11:34:21.300Z&endtime=2015-12-11T11:38:22.600Z", function(result) {
      if (result.length == 0) {
        console.log("No data");
      }
      if (result.length) {
        var combinedPackets = $.extend({}, result[0], result[1]);
        OpsSensorModulesList.updateSensorModuleList(combinedPackets);
        $(".sensorOverlay").fadeOut(300, function() { $(".sensorOverlay").remove(); });
      }
    }).fail(function(jqxhr, textStatus, error) {
      var err = textStatus + ", " + error;
      console.log("Request Failed: " + err)
    });
  },
/*
  Sample data returned from the combined packet object:

  _id: "566ab50b0dd8e408d8c36395"
  acclima_buld_elec_conductivity: "Nil"
  acclima_bulk_rel_permittivity: "Nil"
  acclima_soil_temp: "Nil"
  acclima_vol_water_content: ""
  address: "A1"
  air_humidity_1: "79.00"
  air_humidity_2: "255.00"
  air_humidity_3: "71.00"
  air_temp_1: "7.00"
  air_temp_2: "255.00"
  air_temp_3: "8.00"
  rssi: -75
  sensor: "soil2"
  seq_id: "1"
  soil_moisture_1: "521"
  soil_moisture_2: "553"
  soil_moisture_3: "527"
  soil_temp_1: "6.45"
  soil_temp_2: "50.38"
  soil_temp_3: "7.74"
  surface_flow: "0"
  timestamp: "2015-12-11T11:35:39.222Z"
  __proto__: Object
*/
  updateSensorModuleList: function(results) {
    $('#sensorModuleListHeader').html("Sensor Details: AX");
    $('#sensorModuleListSensorLocation').html("Easting: 123456 | Northing: 567890 | Elevation: 342m");
    $('#sensorModuleListRSSIValue').html(results.rssi);
    $('#sensorModuleListAirTemp1Value').html(results.air_temp_1);
    $('#sensorModuleListAirTemp2Value').html(results.air_temp_2);
    $('#sensorModuleListAirTemp3Value').html(results.air_temp_3);
    $('#sensorModuleListAirHum1Value').html(results.air_humidity_1);
    $('#sensorModuleListAirHum2Value').html(results.air_humidity_2);
    $('#sensorModuleListAirHum3Value').html(results.air_humidity_3);
    $('#sensorModuleListSoilTemp1Value').html(results.soil_temp_1);
    $('#sensorModuleListSoilTemp2Value').html(results.soil_temp_2);
    $('#sensorModuleListSoilTemp3Value').html(results.soil_temp_3);
    $('#sensorModuleListSoilMoist1Value').html(results.soil_moisture_1);
    $('#sensorModuleListSoilMoist2Value').html(results.soil_moisture_2);
    $('#sensorModuleListSoilMoist3Value').html(results.soil_moisture_3);
  },

  getValueChange: function() {
    // TODO: Retieve 5-10 previous records for this sensor and plot the values
    // to in-line visualise how it had/hasn't changed recently.
  },

  loadSelectedModuleInformation: function(data) {
    // TODO: Query the individual soil information from dataset. Currently This
    // data does not exist in the Lancaster envdata db.
    $('#opsSingleSensorHeader').html("Module Information: " + data);
  }

};
