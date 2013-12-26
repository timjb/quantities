module Quantities.NonSIUnits

import Quantities
import Quantities.SIPrefixes
import Quantities.SIBaseUnits
import Quantities.SIDerivedUnits

%default total
%access public


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


-- Mass

tonne : ElemUnit Mass
tonne = < one "t" equals 1000 kg >
t : ElemUnit Mass
t = tonne


-- Angles

degree : ElemUnit PlaneAngle
degree = < one "deg" equals (pi / 180) rad >
deg : ElemUnit PlaneAngle
deg = degree

arcmin : ElemUnit PlaneAngle
arcmin = < one "arcmin" equals (1/60) degree >

arcsec : ElemUnit PlaneAngle
arcsec = < one "arcsec" equals (1/60) arcmin >


-- Length

-- Ångström (Å)
angstrom : ElemUnit Length
angstrom = < one "angstrom" equals 0.1 (nano metre) >

inch : ElemUnit Length
inch = < one "in" equals 0.0254 metre >
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

nauticalMile : ElemUnit Length
nauticalMile = < one "nmi" equals 1852 metre >
nmi : ElemUnit Length
nmi = nauticalMile

-- Astronomical Unit
au : ElemUnit Length
au = MkElemUnit "au" 149597870691


-- Temperature

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

fahrenheit : ElemUnit Temperature
fahrenheit = < one "dF" equals (5/9) K > -- °F
dF : ElemUnit Temperature
dF = fahrenheit

rotationsPerMinute : Unit Frequency
rotationsPerMinute = one <//> minute
rpm : Unit Frequency
rpm = rotationsPerMinute


-- Area

are : ElemUnit Area
are = < one "are" equals 100 (metre ^^ 2) >

hectare : ElemUnit Area
hectare = < one "ha" equals 1 ((hecto metre) ^^ 2) >
ha : ElemUnit Area
ha = hectare

barn : ElemUnit Area
barn = < one "b" equals 100 ((femto metre) ^^ 2) >
b : ElemUnit Area
b = barn


-- Volume

litre : ElemUnit Volume
litre = < one "l" equals 1 (milli (m ^^ 3)) >
liter : ElemUnit Volume
liter = litre
l : ElemUnit Volume
l = litre


-- Pressure

bar : ElemUnit Pressure
bar = < one "bar" equals 100 (kilo pascal) >

millimetreOfMercury : ElemUnit Pressure
millimetreOfMercury = < one "mmHg" equals 133.322 pascal >
mmHg : ElemUnit Pressure
mmHg = millimetreOfMercury


-- Speed

knot : ElemUnit Speed
knot = < one "kn" equals 1 (nauticalMile <//> hour) >
kn : ElemUnit Speed
kn = knot


-- Acceleration

-- Standard gravity
g0 : ElemUnit Force
g0 = MkElemUnit "g" 9.80665
