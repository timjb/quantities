module Quantities.NonSIUnits

import Quantities
import Quantities.SIBaseUnits
import Quantities.SIDerivedUnits

%default total
%access public


-- Scalar values

percent : ElemUnit scalar
percent = MkElemUnit "%" 0.01

promille : ElemUnit scalar
promille = MkElemUnit "‰" 0.001

-- Length

inch : ElemUnit Length
inch = < one "in" equals 0.0254 meter >
in_ : ElemUnit Length
in_ = inch

foot : ElemUnit Length
foot = < one "ft" equals 12 inch >
ft : ElemUnit Length
ft = foot

yard : ElemUnit Length
yard = < one "yd" equals 3 foot >
yd : ElemUnit Length
yd = yard

mile : ElemUnit Length
mile = < one "mile" equals 1760 yard >

-- Astronomical Unit
au : ElemUnit Length
au = MkElemUnit "au" 149597870691


-- Time

minute : ElemUnit Time
minute = < one "min" equals 60 second >
min : ElemUnit Time
min = minute

hour : ElemUnit Time
hour = < one "h" equals 60 minute >
h : ElemUnit Time
h = hour

day : ElemUnit Time
day = < one "d" equals 24 hour >
d : ElemUnit Time
d = day

week : ElemUnit Time
week = < one "week" equals 7 day >

year : ElemUnit Time
year = < one "a" equals 365.25 day >
a : ElemUnit Time
a = year


-- Temperature

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

fahrenheit : ElemUnit Temperature
fahrenheit = MkElemUnit "dF" (5/9) -- °F
dF : ElemUnit Temperature
dF = fahrenheit

-- rotations per minute
rpm : Unit Frequency
rpm = minute ^^ (-1)


-- Area

are : ElemUnit Area
are = MkElemUnit "a" 100


-- Volume

litre : ElemUnit Volume
litre = MkElemUnit "l" 0.001
l : ElemUnit Volume
l = litre


-- Acceleration

-- Standard gravity
g0 : ElemUnit Force
g0 = MkElemUnit "g" 9.80665
