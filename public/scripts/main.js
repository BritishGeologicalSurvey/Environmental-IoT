require.config({
  stubModules: ['cs', 'tpl'],
  shim: {
    'bootstrap': { deps: ['jquery']},
  },
  paths: {
    'backbone':      '../vendor/backbone/backbone',
    'bootstrap':     '../vendor/bootstrap/dist/js/bootstrap.min',
    'cs':            '../vendor/require-cs/cs',
    'coffee-script': '../vendor/coffee-script/extras/coffee-script',
    'tpl':           '../vendor/requirejs-tpl/tpl',
    'text':          '../vendor/requirejs-text/text',
    'jquery':        '../vendor/jquery/dist/jquery',
    'underscore':    '../vendor/underscore/underscore'
  },
  waitSeconds:1000
});

require(['cs!Main'], function() {});