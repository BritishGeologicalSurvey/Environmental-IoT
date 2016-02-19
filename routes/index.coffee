express = require 'express'
path    = require 'path'

module.exports = ->
  router = express.Router()

  router.get '/404',           (req, res) -> res.render '404'
  router.get '/',              (req, res) -> res.render 'index'
  router.get '/ops',           (req, res) -> res.render 'index'
  router.get '/deSoil',        (req, res) -> res.render 'deSoil'
  router.get '/deSheep',       (req, res) -> res.render 'deSheep'
  router.get '/deWeather',       (req, res) -> res.render 'deWeather'
  router.get '/notifications', (req, res) -> res.render 'notifications'

  return router