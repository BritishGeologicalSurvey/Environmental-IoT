/*
 * Author: Abdullah A Almsaeed
 * Date: 4 Jan 2014
 * Description:
 *      This is a demo file used only for the main dashboard (index.html)
 **/

$(function() {

  "use strict";

  //Make the dashboard widgets sortable Using jquery UI
  $(".connectedSortable").sortable({
    placeholder: "sort-highlight",
    connectWith: ".connectedSortable",
    handle: ".box-header, .nav-tabs",
    forcePlaceholderSize: true,
    zIndex: 999999
  });
  $(".connectedSortable .box-header, .connectedSortable .nav-tabs-custom").css("cursor", "move");

  //jQuery UI sortable for the todo list
  $(".todo-list").sortable({
    placeholder: "sort-highlight",
    handle: ".handle",
    forcePlaceholderSize: true,
    zIndex: 999999
  });

  //bootstrap WYSIHTML5 - text editor
  $(".textarea").wysihtml5();

  /* jQueryKnob */
  $(".knob").knob();

  //jvectormap data
  var visitorsData = {
    "US": 398, //USA
    "SA": 400, //Saudi Arabia
    "CA": 1000, //Canada
    "DE": 500, //Germany
    "FR": 760, //France
    "CN": 300, //China
    "AU": 700, //Australia
    "BR": 600, //Brazil
    "IN": 800, //India
    "GB": 320, //Great Britain
    "RU": 3000 //Russia
  };
  //World map by jvectormap
  $('#world-map').vectorMap({
    map: 'world_mill_en',
    backgroundColor: "transparent",
    regionStyle: {
      initial: {
        fill: '#e4e4e4',
        "fill-opacity": 1,
        stroke: 'none',
        "stroke-width": 0,
        "stroke-opacity": 1
      }
    },
    series: {
      regions: [{
        values: visitorsData,
        scale: ["#92c1dc", "#ebf4f9"],
        normalizeFunction: 'polynomial'
      }]
    },
    onRegionLabelShow: function(e, el, code) {
      if (typeof visitorsData[code] != "undefined")
        el.html(el.html() + ': ' + visitorsData[code] + ' new visitors');
    }
  });

  //Sparkline charts
  var myvalues = [1000, 1200, 920, 927, 931, 1027, 819, 930, 1021];
  $('#sparkline-1').sparkline(myvalues, {
    type: 'line',
    lineColor: '#92c1dc',
    fillColor: "#ebf4f9",
    height: '50',
    width: '80'
  });
  myvalues = [515, 519, 520, 522, 652, 810, 370, 627, 319, 630, 921];
  $('#sparkline-2').sparkline(myvalues, {
    type: 'line',
    lineColor: '#92c1dc',
    fillColor: "#ebf4f9",
    height: '50',
    width: '80'
  });
  myvalues = [15, 19, 20, 22, 33, 27, 31, 27, 19, 30, 21];
  $('#sparkline-3').sparkline(myvalues, {
    type: 'line',
    lineColor: '#92c1dc',
    fillColor: "#ebf4f9",
    height: '50',
    width: '80'
  });

  //The Calender
  $("#calendar").datepicker();

  //SLIMSCROLL FOR CHAT WIDGET
  $('#chat-box').slimScroll({
    height: '250px'
  });

  $('.daterange').daterangepicker({
      ranges: {
        'Today': [moment(), moment()],
        'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
        'Last 7 Days': [moment().subtract('days', 6), moment()],
        'Last 30 Days': [moment().subtract('days', 29), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
      },
      startDate: moment().subtract('days', 29),
      endDate: moment()
    },
    function(start, end) {
      alert("You chose: " + start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    });

  var sheepTrackSelectMinDate = new Date("July 13, 2015 00:00:00");
  var sheepTrackSelectMaxDate = new Date("December 17, 2015 00:00:00");
  $('#sheepTrackSelectDateTime').datetimepicker({
    format: 'DD-MM-YYYY, HH:mm',
    sideBySide: true,
    minDate: sheepTrackSelectMinDate,
    maxDate: sheepTrackSelectMaxDate
  });

  var sheepHeatSelectMinDate = new Date("July 13, 2015 00:00:00");
  var sheepHeatSelectMaxDate = new Date("December 17, 2015 00:00:00");
  $('#sheepHeatSelectDate').datetimepicker({
    format: 'DD-MM-YYYY',
    minDate: sheepHeatSelectMinDate,
    maxDate: sheepHeatSelectMaxDate
  });

  $("#sheepHeatSelectDate").on("dp.change", function(e) {
    if (!e.oldDate) {
    }
    else {
      var dt = $('#sheepHeatSelectDate').data("DateTimePicker").date()
      SheepPositionHeatMap.loadSpecificData(dt);
      $("<div id='sheepHeatMapOverlay' class='overlay'><i class='fa fa-cog fa-spin'></i></div>").appendTo("#sheepHeatMapDiv").hide().fadeIn(300);
    }

  });

  $('#SheepButton1').click(function() {
    var dt = $('#sheepTrackSelectDateTime').data("DateTimePicker").date()
    var buttonText = $('#SheepButton1').text();
    if (buttonText == "Start") {
      $('#SheepButton1').text('Stop');
      SheepTraceChart.pollData(
        $('#sheepTrackSelectSheepId').val(),
        dt,
        $('#sheepTrackSelectUpdateFrequency').val(),
        $('#sheepTrackSelectTimePeriod').val()
      );
      // $("#SheepButton1 span").text("My NEW Text");
    } else {
      $('#sheepTrackStatusBar').html("Stopping updates...Please wait.");
      $('#SheepButton1').text('Start');
    }
  });



  /* The todo list plugin */
  $(".todo-list").todolist({
    onCheck: function(ele) {
      window.console.log("The element has been checked");
      return ele;
    },
    onUncheck: function(ele) {
      window.console.log("The element has been unchecked");
      return ele;
    }
  });

});

// (function poll() {
//     $.ajax({
//         url: "http://api.openweathermap.org/data/2.5/find?q=London&units=metric&appid=2de143494c0b295cca9337e1e96b00e0",
//         type: "GET",
//         success: function(data) {
//           var dt = new Date();
//           var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
//           var Results = ("<center><h2>London Wind Speed: " + data.list[1].wind.speed + "mph</h2><br>Last Updated: " + time + "</center>");
//           $('#liveData').html(Results);
//
//           $('#weatherResultsCurrentWeather').text(data.list[1].weather[0].main);
//           $('#weatherResultsTemp').text(data.list[1].main.temp);
//           $('#weatherResultsPressure').text(data.list[1].main.pressure);
//           $('#weatherResultsHumidity').text(data.list[1].main.humidity);
//
//         },
//         dataType: "json",
//         complete: setTimeout(function() {poll()}, 5000),
//         timeout: 2000
//     })
// })();
