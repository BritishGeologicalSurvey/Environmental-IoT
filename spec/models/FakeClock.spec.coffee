FakeClock = require 'models/FakeClock'

describe "FakeClock", ->
  clock = null
  beforeEach ->
    clock = new FakeClock

  it "returns first time when real time is 0", ->
    clock.add new Date(2015,3,12), new Date(2015,3,13)
    spyOn(clock, 'getRealTime').and.returnValue 0
    expect(clock.getTime()).toEqual new Date(2015,3,12)

  it "returns first time after length of period", ->
    start = new Date 2013, 3, 12
    end   = new Date 2014, 3, 13
    clock.add start, end
    spyOn(clock, 'getRealTime').and.returnValue end.getTime() - start.getTime()
    expect(clock.getTime()).toEqual start

  it "returns time midway between times", ->
    clock.add new Date(2015,1,1), new Date(2015,1,2)
    halfADayInMilliseconds = 24 * 60 * 60 * 1000 / 2
    spyOn(clock, 'getRealTime').and.returnValue halfADayInMilliseconds
    expect(clock.getTime()).toEqual new Date 2015, 1, 1, 12, 0

  it "can loop through multiple periods", ->
    clock.add new Date(2015,1,1), new Date(2015,1,2)
    clock.add new Date(2016,1,1), new Date(2016,1,2)
    dayInMilliseconds = 24 * 60 * 60 * 1000    
    spyOn(clock, 'getRealTime').and.returnValue dayInMilliseconds
    expect(clock.getTime()).toEqual new Date 2016, 1, 1
