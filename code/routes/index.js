var express = require('express');
var router = express.Router();
var path = require('path');

router.get('/404', function(req, res, next) {
  res.render('404');
});

router.get('/', function(req, res, next) {
  res.render('index');
});

router.get('/ops', function(req, res, next) {
  res.render('index');
});

router.get('/deSoil', function(req, res, next) {
  res.render('deSoil');
});

router.get('/deSheep', function(req, res, next) {
  res.render('deSheep');
});

router.get('/notifications', function(req, res, next) {
  res.render('notifications');
});

module.exports = router;
