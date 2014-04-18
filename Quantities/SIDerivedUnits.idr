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

newton : Unit Force'
newton = ((meter <//> second) <//> second) <**> kilogram
N : Unit Force'
N = newton

pascal : Unit Pressure
pascal = newton <//> (meter ^^ 2)
Pa : Unit Pressure
Pa = pascal

joule : Unit Energy
joule = newton <**> meter
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
weber = second <**> volt
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
