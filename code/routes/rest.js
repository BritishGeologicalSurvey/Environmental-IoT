/*
  /api/points	GET					Get all the points.
  /api/points/:point_id		GET	Get a single point by its id.
*/

var express = require('express');
var router = express.Router();

var mongoose = require('mongoose');
mongoose.set('debug', true);

var dataModel = require('../models/dataModel.js');

// API ROUTES

// Testing the API is running
// router.get('/api', function(req, res) {
// 	res.json({
// 		message: 'Testing API'
// 	});
// });

/*
  Query Building from URL params
  Expecting:
  - e.g. http://<sitelocation>:<port>/api?sensor=sheep&starttime=xxxxx&endtime=xxxxx
  - sensor=sheep or sensor=soil
  - starttime=xxxxx (ISO Date format)
  - endtime=xxxxx (ISO Date format)

  http://localhost:3000/querynode?nodeid=A6&starttime=2015-12-01T16:21:04.657Z&endtime=2015-12-25T16:21:04.657Z

*/
router.get('/api', function(req, res) {

  dataModel.find({
    $and: [{
      timestamp: {
        "$gte": new Date(req.query.starttime),
        "$lt": new Date(req.query.endtime)
      }
    }, {
      sensor: req.query.sensor,
    }]
  }, function(err, posts) {
    res.json(posts);
  });

});

// Getting values from nodes and their sensors
router.get('/querynode', function(req, res) {

  var moisture_exists;
  if (req.query.packet == 0)
  {
    moisture_exists = false;
  }
  else if (req.query.packet == 1)
  {
    moisture_exists = true;
  }

  dataModel.find({
    $and: [{
      timestamp: {
        "$gte": new Date(req.query.starttime),
        "$lt": new Date(req.query.endtime)
      }
    }, {
      address: req.query.nodeid,
      soil_moisture_1: {$exists: moisture_exists},
    }]
  }, function(err, posts) {
    res.json(posts);
  });

});

router.get('/querysoil', function(req, res) {


  dataModel.find({
    $and: [{
      timestamp: {
        "$gte": new Date(req.query.starttime),
        "$lt": new Date(req.query.endtime)
      }
    }, {
      address: req.query.nodeid,
    }]
  }, function(err, posts) {
    res.json(posts);
  });

});

/// Get all the points up to a limit of 50
router.get('/api/points', function(req, res, next) {

  console.log("Getting all the points.");

  dataModel.find({}, function(err, posts) {
      if (!err){
          res.json(posts);
      } else {throw err;}
  }).limit(50);

});

// Get a single point by its id.
router.get('/api/points/:id', function(req, res, next) {

  console.log("Requesting single record by id: " + req.params.id);

  dataModel.findById(req.params.id, function(err, results) {
    if (err) return next(err);
    if (!results) {
      res.send("NODATA");
    } else {
      res.json(results);
    }
  });
});

module.exports = router;
