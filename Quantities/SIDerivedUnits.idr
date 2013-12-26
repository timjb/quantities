module Quantities.Units

import Quantities
import Quantities.SIBaseQuantities
import Quantities.SIDerivedQuantities
import Quantities.SIBaseUnits

%default total
%access public

radian : Unit PlaneAngle
radian = one
rad : Unit PlaneAngle
rad = one

steradian : Unit SolidAngle
steradian = one
sr : Unit SolidAngle
sr = steradian

hertz : Unit Frequency
hertz = second ^^ (-1)
Hz : Unit Frequency
Hz = hertz

newton : Unit Force
newton = (kilogram <**> meter) <//> (second ^^ 2)
N : Unit Force
N = newton

pascal : Unit Pressure
pascal = newton <//> (meter ^^ 2)
Pa : Unit Pressure
Pa = pascal

joule : Unit Energy
joule = (kilogram <**> (meter ^^ 2)) <//> (second ^^ 2)
J : Unit Energy
J = joule

watt : Unit Power
watt = joule <//> second
W : Unit Power
W = watt

coulomb : Unit ElectricCharge
coulomb = second <**> ampere
C : Unit ElectricCharge
C = coulomb

volt : Unit ElectricPotentialDifference
volt = watt <//> ampere
V : Unit ElectricPotentialDifference
V = volt

farad : Unit Capacitance
farad = coulomb <//> volt
F : Unit Capacitance
F = farad

ohm : Unit ElectricResistance
ohm = volt <//> ampere

siemens : Unit ElectricConductance
siemens = ampere <//> volt
S : Unit ElectricConductance
S = siemens

weber : Unit MagneticFlux
weber = volt <**> second
Wb : Unit MagneticFlux
Wb = weber

tesla : Unit MagneticFluxDensity
tesla = weber <//> (meter ^^ 2)
T : Unit MagneticFluxDensity
T = tesla

henry : Unit Inductance
henry = weber <//> ampere
H : Unit Inductance
H = henry

-- For relative temperature measurements
celsius : Unit Temperature
celsius = kelvin
dC : Unit Temperature
dC = celsius

lumen : Unit LuminousFlux
lumen = candela <**> steradian
lm : Unit LuminousFlux
lm = lumen

lux : Unit Illuminance
lux = lumen <//> (meter ^^ 2)
lx : Unit Illuminance
lx = lux

becquerel : Unit ActivityReferredToARadionuclide
becquerel = second ^^ (-1)
Bq : Unit ActivityReferredToARadionuclide
Bq = becquerel

gray : Unit AbsorbedDose
gray = joule <//> kilogram
Gy : Unit AbsorbedDose
Gy = gray

sievert : Unit DoseEquivalent
sievert = joule <//> kilogram
Sv : Unit DoseEquivalent
Sv = sievert

katal : Unit CatalyticActivity
katal = mol <//> second
kat : Unit CatalyticActivity
kat = katal



{-
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

-}
