require.config({
  stubModules: ['cs', 'tpl'],
  shim: {
    'bootstrap': { deps: ['jquery']},
    'amcharts': { exports: 'AmCharts' },
    'amstock': {deps: ['serial'] },
    'serial': { deps: ['amcharts'] },
    'leaflet-heat': { deps: ['leaflet'] }
  },
  paths: {
    'backbone':      '../vendor/backbone/backbone',
    'bootstrap':     '../vendor/bootstrap/dist/js/bootstrap.min',
    'cs':            '../vendor/require-cs/cs',
    'coffee-script': '../vendor/coffee-script/extras/coffee-script',
    'leaflet':       '../vendor/leaflet/dist/leaflet',
    'leaflet-heat':  '../vendor/leaflet.heat/dist/leaflet-heat',
    'tpl':           '../vendor/requirejs-tpl/tpl',
    'text':          '../vendor/requirejs-text/text',
    'jquery':        '../vendor/jquery/dist/jquery',
    'underscore':    '../vendor/underscore/underscore',
    'sparkline':     '../vendor/AdminLTE/plugins/sparkline/jquery.sparkline',
    'amcharts':      '../vendor/amstock3/amcharts/amcharts',
    'amstock':       '../vendor/amstock3/amcharts/amstock',
    'serial':        '../vendor/amstock3/amcharts/serial'
  },
  waitSeconds:1000
});

require(['cs!Main'], function() {});