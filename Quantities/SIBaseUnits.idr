module Quantities.SIBaseUnits

import Quantities.Core
import Quantities.SIPrefixes
import Quantities.SIBaseQuantities

%default total
%access public export

Metre : ElemUnit Length
Metre = MkElemUnit "m" 1
Meter : ElemUnit Length
Meter = Metre
M : ElemUnit Length
M = Meter

Centimetre : Unit Length
Centimetre = centi Metre
Centimeter : Unit Length
Centimeter = Centimetre
Cm : Unit Length
Cm = Centimetre

Kilometre : Unit Length
Kilometre = kilo Metre
Kilometer : Unit Length
Kilometer = Kilometre
Km : Unit Length
Km = Kilometre

Gram : ElemUnit Mass
Gram = MkElemUnit "g" 0.001
G : ElemUnit Mass
G = Gram

Kilogram : Unit Mass
Kilogram = kilo Gram
Kg : Unit Mass
Kg = Kilogram

Second : ElemUnit Time
Second = MkElemUnit "s" 1
S : ElemUnit Time
S = Second

Ampere : ElemUnit ElectricCurrent
Ampere = MkElemUnit "A" 1
A : ElemUnit ElectricCurrent
A = Ampere

Kelvin : ElemUnit Temperature
Kelvin = MkElemUnit "K" 1
K : ElemUnit Temperature
K = Kelvin

Mole : ElemUnit AmountOfSubstance
Mole = MkElemUnit "mol" 1
Mol : ElemUnit AmountOfSubstance
Mol = Mole

Candela : ElemUnit LuminousIntensity
Candela = MkElemUnit "cd" 1
Cd : ElemUnit LuminousIntensity
Cd = Candela
