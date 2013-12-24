module Quantities.Units

import Quantities
import Quantities.Quantities

%default total
%access public


-- Scalar values

percent : ElemUnit scalar
percent = MkElemUnit "%" 0.01

promille : ElemUnit scalar
promille = MkElemUnit "‰" 0.001

mol : ElemUnit scalar
mol = MkElemUnit "mol" 6.02214129e23

-- Length

meter : ElemUnit Length
meter = MkElemUnit "m" 1

inch : ElemUnit Length
inch = one "in" is 0.0254 meter

foot : ElemUnit Length
foot = one "ft" is 12 inch

yard : ElemUnit Length
yard = one "yd" is 3 foot

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

-- TODO: use general 'kilo', 'milli', etc. combinators
kilogram : ElemUnit Mass
kilogram = MkElemUnit "kg" 1


-- Time

second : ElemUnit Time
second = MkElemUnit "s" 1

minute : ElemUnit Time
minute = one "min" is 60 second

hour : ElemUnit Time
hour = one "h" is 60 minute

day : ElemUnit Time
day = one "d" is 24 hour

week : ElemUnit Time
week = one "week" is 7 day

year : ElemUnit Time
year = one "a" is 365.25 day


-- Temperature

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

kelvin : ElemUnit Temperature
kelvin = MkElemUnit "°K" 1

celsius : ElemUnit Temperature
celsius = MkElemUnit "°C" 1

fahrenheit : ElemUnit Temperature
fahrenheit = MkElemUnit "°F" (5/9)


-- Frequency

hz : Unit Frequency
hz = second ^^ (-1)

-- rotations per minute
rpm : Unit Frequency
rpm = minute ^^ (-1)


-- Area

are : ElemUnit Area
are = MkElemUnit "a" 100


-- Volume

litre : ElemUnit Volume
litre = MkElemUnit "l" 0.001


-- Concentration

molar : Unit Concentration
molar = mol <//> litre


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


-- Pressure

pascal : Unit Pressure
pascal = newton <//> (meter ^^ 2)
