require.config({
  stubModules: ['cs', 'tpl'],
  shim: {
    'adminlte': { deps: ['jquery', 'jquery-ui']},
    'bootstrap': { deps: ['jquery']},
    'amcharts': { exports: 'AmCharts' },
    'amstock': {deps: ['serial'] },
    'serial': { deps: ['amcharts'] },
    'leaflet-heat': { deps: ['leaflet'] }
  },
  paths: {
    'adminlte':                 '../vendor/AdminLTE/dist/js/app',
    'backbone':                 '../vendor/backbone/backbone',
    'bootstrap':                '../vendor/bootstrap/dist/js/bootstrap.min',
    'bootstrap-datetimepicker': '../vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min',
    'cs':                       '../vendor/require-cs/cs',
    'coffee-script':            '../vendor/coffee-script/extras/coffee-script',
    'leaflet':                  '../vendor/leaflet/dist/leaflet',
    'leaflet-heat':             '../vendor/Leaflet.heat/dist/leaflet-heat',
    'tpl':                      '../vendor/requirejs-tpl/tpl',
    'text':                     '../vendor/requirejs-text/text',
    'jquery':                   '../vendor/jquery/dist/jquery',
    'jquery-ui':                '../vendor/AdminLTE/plugins/jQueryUI/jquery-ui',
    'moment':                   '../vendor/moment/moment',
    'underscore':               '../vendor/underscore/underscore',
    'sparkline':                '../vendor/AdminLTE/plugins/sparkline/jquery.sparkline',
    'amcharts':                 '../vendor/amstock3/amcharts/amcharts',
    'amstock':                  '../vendor/amstock3/amcharts/amstock',
    'serial':                   '../vendor/amstock3/amcharts/serial'
  },
  waitSeconds:1000
});

require(['cs!Main'], function() {});