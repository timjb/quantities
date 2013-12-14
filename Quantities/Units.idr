module Quantities.Units

import Quantities
import Quantities.Quantities

%default total


-- Scalar values

percent : ElemUnit scalar
percent = MkElemUnit "%" 0.01

promille : ElemUnit scalar
promille = MkElemUnit "‰" 0.001

mol : ElemUnit scalar
mol = MkElemUnit "mol" 6.02214129e23


-- Length

meter : ElemUnit length
meter = MkElemUnit "m" 1

inch : ElemUnit length
inch = one "in" is 0.0254 meter

foot : ElemUnit length
foot = one "ft" is 12 inch

yard : ElemUnit length
yard = one "yd" is 3 foot

mile : ElemUnit length
mile = one "mile" is 1760 yard

-- TODO: use general 'kilo', 'milli', etc. combinators
kilometer : ElemUnit length
kilometer = MkElemUnit "km" 1000

-- Astronomical Unit
au : ElemUnit length
au = MkElemUnit "au" 149597870691


-- Mass

gram : ElemUnit mass
gram = MkElemUnit "g" 0.001

-- TODO: use general 'kilo', 'milli', etc. combinators
kilogram : ElemUnit mass
kilogram = MkElemUnit "kg" 1


-- Time

second : ElemUnit time
second = MkElemUnit "s" 1

minute : ElemUnit time
minute = one "min" is 60 second

hour : ElemUnit time
hour = one "h" is 60 minute

day : ElemUnit time
day = one "d" is 24 hour

week : ElemUnit time
week = one "week" is 7 day

year : ElemUnit time
year = one "a" is 365.25 day


-- Temperature

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

kelvin : ElemUnit temperature
kelvin = MkElemUnit "°K" 1

celsius : ElemUnit temperature
celsius = MkElemUnit "°C" 1

fahrenheit : ElemUnit temperature
fahrenheit = MkElemUnit "°F" (5/9)


-- Frequency

hz : Unit frequency
hz = ConsUnit second (-1) EmptyUnit

-- rotations per minute
rpm : Unit frequency
rpm = ConsUnit minute (-1) EmptyUnit


-- Area

are : ElemUnit area
are = MkElemUnit "a" 100


-- Volume

litre : ElemUnit volume
litre = MkElemUnit "l" 0.001


-- Concentration

molar : Unit concentration
molar = ConsUnit mol 1 (ConsUnit litre (-1) EmptyUnit)


-- Speed

kmh : Unit speed
kmh = ConsUnit kilometer 1 (ConsUnit hour (-1) EmptyUnit)

ms : Unit speed
ms = ConsUnit meter 1 (ConsUnit second (-1) EmptyUnit)


-- Acceleration

-- Standard gravity
g0 : ElemUnit gravity
g0 = MkElemUnit "g" 9.80665


-- Force

--newton : Unit force
--newton = ConsUnit kilogram 1 (ConsUnit meter 1 (ConsUnit second (-2) EmptyUnit))


-- Energy

--joule : Unit energy
--joule = ConsUnit kilogram 1 (ConsUnit meter 2 (ConsUnit second (-2) EmptyUnit))
