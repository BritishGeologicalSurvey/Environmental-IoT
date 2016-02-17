define [
  'underscore'
  'backbone'
], (_, Backbone)-> Backbone.Model.extend
  url: '/time'

  initialize: ->
    @on 'sync', @storeOffset

  ###
  Calculate the difference between the local system time and the retrieved
  server time. The calculation assumes that round trip time is zero.
  ###
  storeOffset: -> 
    @offset = new Date() - new Date(@get 'systemTime')

  ###
  Return the system time calculated by subracting the offset between local 
  and server time
  ###
  getTime: -> new Date new Date() - @offset