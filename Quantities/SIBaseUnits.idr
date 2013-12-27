module Quantities.SIBaseUnits

import Quantities
import Quantities.SIPrefixes
import Quantities.SIBaseQuantities

%default total
%access public

metre : ElemUnit Length
metre = MkElemUnit "m" 1
meter : ElemUnit Length
meter = metre
m : ElemUnit Length
m = meter

centimetre : Unit Length
centimetre = centi metre
centimeter : Unit Length
centimeter = centimetre
cm : Unit Length
cm = centimetre

kilometre : Unit Length
kilometre = kilo metre
kilometer : Unit Length
kilometer = kilometre
km : Unit Length
km = kilometre

gram : ElemUnit Mass
gram = MkElemUnit "g" 0.001
g : ElemUnit Mass
g = gram

kilogram : Unit Mass
kilogram = kilo gram
kg : Unit Mass
kg = kilogram

second : ElemUnit Time
second = MkElemUnit "s" 1
s : ElemUnit Time
s = second

ampere : ElemUnit ElectricCurrent
ampere = MkElemUnit "A" 1
A : ElemUnit ElectricCurrent
A = ampere

kelvin : ElemUnit Temperature
kelvin = MkElemUnit "K" 1
K : ElemUnit Temperature
K = kelvin

mole : ElemUnit AmountOfSubstance
mole = MkElemUnit "mol" 1
mol : ElemUnit AmountOfSubstance
mol = mole

candela : ElemUnit LuminousIntensity
candela = MkElemUnit "cd" 1
cd : ElemUnit LuminousIntensity
cd = candela
