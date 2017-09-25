module Quantities.Units

import Quantities.Core
import Quantities.SIBaseQuantities
import Quantities.SIDerivedQuantities
import Quantities.SIBaseUnits

%default total
%access public export

Radian : Unit PlaneAngle
Radian = One
Rad : Unit PlaneAngle
Rad = One

Steradian : Unit SolidAngle
Steradian = One
Sr : Unit SolidAngle
Sr = Steradian

Hertz : Unit Frequency
Hertz = Second ^^ (-1)
Hz : Unit Frequency
Hz = Hertz

Newton : Unit Force'
Newton = ((Metre <//> Second) <//> Second) <**> Kilogram
N : Unit Force'
N = Newton

Pascal : Unit Pressure
Pascal = Newton <//> (Metre ^^ 2)
Pa : Unit Pressure
Pa = Pascal

Joule : Unit Energy
Joule = Newton <**> Metre
J : Unit Energy
J = Joule

Watt : Unit Power
Watt = Joule <//> Second
W : Unit Power
W = Watt

Coulomb : Unit ElectricCharge
Coulomb = Second <**> Ampere
C : Unit ElectricCharge
C = Coulomb

Volt : Unit ElectricPotentialDifference
Volt = Watt <//> Ampere
V : Unit ElectricPotentialDifference
V = Volt

Farad : Unit Capacitance
Farad = Coulomb <//> Volt
F : Unit Capacitance
F = Farad

Ohm : Unit ElectricResistance
Ohm = Volt <//> Ampere

Siemens : Unit ElectricConductance
Siemens = Ampere <//> Volt
S : Unit ElectricConductance
S = Siemens

Weber : Unit MagneticFlux
Weber = Second <**> Volt
Wb : Unit MagneticFlux
Wb = Weber

Tesla : Unit MagneticFluxDensity
Tesla = Weber <//> (Metre ^^ 2)
T : Unit MagneticFluxDensity
T = Tesla

Henry : Unit Inductance
Henry = Weber <//> Ampere
H : Unit Inductance
H = Henry

-- For relative temperature measurements
Celsius : Unit Temperature
Celsius = Kelvin
DC : Unit Temperature
DC = Celsius

Lumen : Unit LuminousFlux
Lumen = Candela <**> Steradian
Lm : Unit LuminousFlux
Lm = Lumen

Lux : Unit Illuminance
Lux = Lumen <//> (Metre ^^ 2)
Lx : Unit Illuminance
Lx = Lux

Becquerel : Unit ActivityReferredToARadionuclide
Becquerel = Second ^^ (-1)
Bq : Unit ActivityReferredToARadionuclide
Bq = Becquerel

Gray : Unit AbsorbedDose
Gray = Joule <//> Kilogram
Gy : Unit AbsorbedDose
Gy = Gray

Sievert : Unit DoseEquivalent
Sievert = Joule <//> Kilogram
Sv : Unit DoseEquivalent
Sv = Sievert

Katal : Unit CatalyticActivity
Katal = Mol <//> Second
Kat : Unit CatalyticActivity
Kat = Katal
