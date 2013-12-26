module Quantities.SIBaseQuantities

import Quantities

%default total
%access public

Length : Dimension
Length = MkDimension "Length"

Mass : Dimension
Mass = MkDimension "Mass"

Time : Dimension
Time = MkDimension "Time"

ElectricCurrent : Dimension
ElectricCurrent = MkDimension "ElectricCurrent"

-- Thermodynamic temperature
Temperature : Dimension
Temperature = MkDimension "Temperature"

AmountOfSubstance : Dimension
AmountOfSubstance = MkDimension "AmountOfSubstance"

LuminousIntensity : Dimension
LuminousIntensity = MkDimension "LuminousIntensity"
