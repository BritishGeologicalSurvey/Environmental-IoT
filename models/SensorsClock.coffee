FakeClock = require './FakeClock'

# The following defines an instance of a FakeClock which loops around the
# dates which the sensors were deployed.
module.exports = clock = new FakeClock

clock.add new Date(2015,  7,  13), new Date(2015,  7, 15)
clock.add new Date(2015,  7,  17), new Date(2015,  7, 18)
clock.add new Date(2015,  7,  21), new Date(2015,  7, 22)
clock.add new Date(2015,  7,  28), new Date(2015,  8,  2)
clock.add new Date(2015,  8,   3), new Date(2015,  8,  8)
clock.add new Date(2015,  8,  10), new Date(2015,  8, 12)
clock.add new Date(2015,  8,  17), new Date(2015,  8, 25)
clock.add new Date(2015,  8,  26), new Date(2015,  8, 29)
clock.add new Date(2015,  9,   1), new Date(2015,  9,  5)
clock.add new Date(2015,  9,   7), new Date(2015,  9, 19)
clock.add new Date(2015,  9,  23), new Date(2015,  9, 26)
clock.add new Date(2015,  9,  30), new Date(2015, 10,  4)
clock.add new Date(2015, 11,  18), new Date(2015, 11, 22)
clock.add new Date(2015, 11,  27), new Date(2015, 12, 22)
clock.add new Date(2016,  1,  20), new Date(2016,  1, 21)
clock.add new Date(2016,  1,  28), new Date(2016,  1, 21)
