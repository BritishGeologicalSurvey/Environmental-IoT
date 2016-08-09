define [
  'jquery'
  'underscore'
  'backbone'
], ($, _, Backbone)-> Backbone.Model.extend
  url: '/time'

  initialize: ->
    @on 'sync', @storeOffset
    # @currentClockOffset = "2015-12-18T09:05:00Z"
    @currentClockOffset = "2015-07-21T11:40:00Z"

  ###
  Calculate the difference between the local system time and the retrieved
  server time. The calculation assumes that round trip time is zero.
  ###
  storeOffset: ->
    console.log "storeOffset run"
    @offset = new Date() - new Date(@currentClockOffset)
    # @offset = new Date() - new Date(@get 'systemTime')

  ###
  Return the system time calculated by subracting the offset between local
  and server time
  ###
  getTime: -> new Date new Date() - @offset

  ###
  Repeatedly poll the server for to keep with the latest server time
  ###
  poll: (after = 30000) -> @fetch().always =>_.delay (=> @poll after), after
