define [
  'jquery'
  'backbone'
], ($, Backbone)-> Backbone.View.extend
  el: '#dateNowText'

  initialize: (options) ->
    @clock = options.clock
    # @listenTo @nodeRegistry, 'sync', @refresh
    @listenTo @clock, 'sync', @refresh
    console.log "TimeControlView initialised"

  ###
  Update the display of how many nodes are online over how many are known about
  ###
  refresh: ->
    now = @clock.getTime()
    console.log "time = " + now
    $ ->
      $("#dateNowText").text(now)

  # updateTime: ->
  #   now = @model.clock.getTime()
  #   now.setHours 0,0,0,0 # Move this time to midnight
  #   @time.data('DateTimePicker').maxDate now
