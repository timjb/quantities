module Quantities.Units

import Quantities
import Quantities.SIBaseQuantities
import Quantities.SIDerivedQuantities

%default total
%access public


-- Scalar values

percent : ElemUnit scalar
percent = MkElemUnit "%" 0.01

promille : ElemUnit scalar
promille = MkElemUnit "‰" 0.001

-- Length

meter : ElemUnit Length
meter = MkElemUnit "m" 1
m : ElemUnit Length
m = meter

inch : ElemUnit Length
inch = one "in" is 0.0254 meter
in_ : ElemUnit Length
in_ = inch

foot : ElemUnit Length
foot = one "ft" is 12 inch
ft : ElemUnit Length
ft = foot

yard : ElemUnit Length
yard = one "yd" is 3 foot
yd : ElemUnit Length
yd = yard

mile : ElemUnit Length
mile = one "mile" is 1760 yard

-- TODO: use general 'kilo', 'milli', etc. combinators
kilometer : ElemUnit Length
kilometer = MkElemUnit "km" 1000

-- Astronomical Unit
au : ElemUnit Length
au = MkElemUnit "au" 149597870691


-- Mass

gram : ElemUnit Mass
gram = MkElemUnit "g" 0.001
g : ElemUnit Mass
g = gram

-- TODO: use general 'kilo', 'milli', etc. combinators
kilogram : ElemUnit Mass
kilogram = MkElemUnit "kg" 1


-- Time

second : ElemUnit Time
second = MkElemUnit "s" 1
s : ElemUnit Time
s = second

minute : ElemUnit Time
minute = one "min" is 60 second
min : ElemUnit Time
min = minute

hour : ElemUnit Time
hour = one "h" is 60 minute
h : ElemUnit Time
h = hour

day : ElemUnit Time
day = one "d" is 24 hour
d : ElemUnit Time
d = day

week : ElemUnit Time
week = one "week" is 7 day

year : ElemUnit Time
year = one "a" is 365.25 day
a : ElemUnit Time
a = year


-- Temperature

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

kelvin : ElemUnit Temperature
kelvin = MkElemUnit "dK" 1 -- °K
dK : ElemUnit Temperature
dK = kelvin

celsius : ElemUnit Temperature
celsius = MkElemUnit "dC" 1 -- °C
dC : ElemUnit Temperature
dC = celsius

fahrenheit : ElemUnit Temperature
fahrenheit = MkElemUnit "dF" (5/9) -- °F
dF : ElemUnit Temperature
dF = fahrenheit


-- Frequency

hertz : Unit Frequency
hertz = second ^^ (-1)
Hz : Unit Frequency
Hz = hertz

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


-- Speed

kmh : Unit Speed
kmh = kilometer <//> hour

ms : Unit Speed
ms = meter <//> second


-- Acceleration

-- Standard gravity
g0 : ElemUnit Force
g0 = MkElemUnit "g" 9.80665


-- Force

newton : Unit Force
newton = (kilogram <**> meter) <//> (second ^^ 2)


-- Energy

joule : Unit Energy
joule = (kilogram <**> (meter ^^ 2)) <//> (second ^^ 2)
J : Unit Energy
J = joule


-- Pressure

pascal : Unit Pressure
pascal = newton <//> (meter ^^ 2)
Pa : Unit Pressure
Pa = pascal
