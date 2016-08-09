define [
  'jquery'
  'backbone'
], ($, Backbone)-> Backbone.View.extend
  el: '#timeSelectDropdown'

  events:
    'change': 'dropDownDingDong'

  initialize: (options) ->
    @clock = options.clock
    # @listenTo @nodeRegistry, 'sync', @refresh
    @listenTo @clock, 'sync', @refresh
    console.log "TimeControlView initialised"

    ###
    Listen to changes in drop down menu and change current app time
    to user-selected date
    ###
    # $ ->
    # console.log "BING = " + @$('#timeSelectDropdown option').filter(':selected').text()
    #
    # @$('#timeSelectDropdown').change ->
    #   console.log "setting event"
    #   selected = @$('#timeSelectDropdown option').filter(':selected').text()
    #   formattedDate = new Date(selected)
    #   @$("#dateNowText").text(formattedDate)
      # @clock.currentClockOffset = selected
      # @clock.storeOffset()
    #   console.log "run storeoffset manually"

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

  dropDownDingDong: (evt) ->
    console.log "Changing clock time to: " + evt.target.value
    @clock.currentClockOffset = evt.target.value
    @clock.storeOffset()
    @clock.poll()
