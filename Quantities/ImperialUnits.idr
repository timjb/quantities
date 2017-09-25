module Quantities.ImperialUnits

import Quantities.Core
import Quantities.SIBaseQuantities
import Quantities.SIPrefixes
import Quantities.SIBaseUnits
import Quantities.SIDerivedQuantities
import Quantities.NonSIUnits

%default total
%access public export


-- Based on http://en.wikipedia.org/wiki/Imperial_units


-- Length

Thou : ElemUnit Length
Thou = < one "th" equals 25.4 (micro Metre) >
Th : ElemUnit Length
Th = Thou

Inch : ElemUnit Length
Inch = < one "in" equals 2.54 Centimetre >
In_ : ElemUnit Length
In_ = Inch

Foot : ElemUnit Length
Foot = < one "ft" equals 12 Inch >
Ft : ElemUnit Length
Ft = Foot

Yard : ElemUnit Length
Yard = < one "yd" equals 3 Foot >
Yd : ElemUnit Length
Yd = Yard

Chain : ElemUnit Length
Chain = < one "ch" equals 22 Yard >
Ch : ElemUnit Length
Ch = Chain

Furlong : ElemUnit Length
Furlong = < one "fur" equals 10 Chain >
Fur : ElemUnit Length
Fur = Furlong

Mile : ElemUnit Length
Mile = < one "mi" equals 1760 Yard >
Mi : ElemUnit Length
Mi = Mile

League : ElemUnit Length
League = < one "lea" equals 3 Mile >
Lea : ElemUnit Length
Lea = League

-- Maritime units

Fathom : ElemUnit Length
Fathom = < one "ftm" equals 6.08 Foot >
Ftm : ElemUnit Length
Ftm = Fathom

Cable : ElemUnit Length
Cable = < one "cable" equals 608 Foot >

NauticalMile : ElemUnit Length
NauticalMile = < one "nmi" equals 1852 Metre >
Nmi : ElemUnit Length
Nmi = NauticalMile

-- Gunter's survey units

Link : ElemUnit Length
Link = < one "link" equals (1/100) Chain >

Rod : ElemUnit Length
Rod = < one "rod" equals (1/4) Chain >


-- Speed

Knot : ElemUnit Speed
Knot = < one "kn" equals 1 (NauticalMile <//> Hour) >
Kn : ElemUnit Speed
Kn = Knot


-- Area

Perch : ElemUnit Area
Perch = < one "perch" equals 1 (Rod ^^ 2) >

Rood : ElemUnit Area
Rood = < one "rood" equals 1 (Furlong <**> Rod) >

Acre : ElemUnit Area
Acre = < one "acre" equals 1 (Furlong <**> Chain) >


-- Volume

FluidOunce : ElemUnit Volume
FluidOunce = < one "floz" equals 28.4130625 (milli $ (deci Metre) ^^ 3) >
Floz : ElemUnit Volume
Floz = FluidOunce

Gill : ElemUnit Volume
Gill = < one "gi" equals 5 FluidOunce >
Gi : ElemUnit Volume
Gi = Gill

Pint : ElemUnit Volume
Pint = < one "pt" equals 20 FluidOunce >
Pt : ElemUnit Volume
Pt = Pint

Quart : ElemUnit Volume
Quart = < one "qt" equals 40 FluidOunce >
Qt : ElemUnit Volume
Qt = Quart

Gallon : ElemUnit Volume
Gallon = < one "gal" equals 160 FluidOunce >
Gal : ElemUnit Volume
Gal = Gallon

-- British apothecaries' volume measures

Minim : ElemUnit Volume
Minim = < one "min" equals 59.1938802083 (micro $ (deci Metre) ^^ 3) >
Min : ElemUnit Volume
Min = Minim

FluidScruple : ElemUnit Volume
FluidScruple = < one "fls" equals 20 Minim >
Fls : ElemUnit Volume
Fls = FluidScruple

FluidDrachm : ElemUnit Volume
FluidDrachm = < one "fldr" equals 3 FluidScruple >
Fldr : ElemUnit Volume
Fldr = FluidDrachm


-- Mass

Pound : ElemUnit Mass
Pound = < one "lb" equals 453.59237 Gram >
Lb : ElemUnit Mass
Lb = Pound

Grain : ElemUnit Mass
Grain = < one "gr" equals (1/7000) Pound >
Gr : ElemUnit Mass
Gr = Grain

Drachm : ElemUnit Mass
Drachm = < one "dr" equals (1/256) Pound >
Dr : ElemUnit Mass
Dr = Drachm

Ounce : ElemUnit Mass
Ounce = < one "oz" equals (1/16) Pound >
Oz : ElemUnit Mass
Oz = Ounce

Stone : ElemUnit Mass
Stone = < one "st" equals 14 Pound >
St : ElemUnit Mass
St = Stone

Quarter : ElemUnit Mass
Quarter = < one "qtr" equals 28 Pound >
Qtr : ElemUnit Mass
Qtr = Quarter

Hundredweight : ElemUnit Mass
Hundredweight = < one "cwt" equals 112 Pound >
Cwt : ElemUnit Mass
Cwt = Hundredweight

Ton : ElemUnit Mass
Ton = < one "ton" equals 2240 Pound >


-- Energy

FootPound : ElemUnit Energy
FootPound = < one "ftlb" equals 1 (Foot <**> Pound <**> G_0) >
Ftlb : ElemUnit Energy
Ftlb = FootPound


-- Power

MechanicalHorsepower : ElemUnit Power
MechanicalHorsepower = < one "hp" equals 550 (FootPound <//> Second) >
ImperialHorsepower : ElemUnit Power
ImperialHorsepower = MechanicalHorsepower
Horsepower : ElemUnit Power
Horsepower = MechanicalHorsepower
Hp : ElemUnit Power
Hp = MechanicalHorsepower
