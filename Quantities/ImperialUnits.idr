module Quantities.ImperialUnits

import Quantities
import Quantities.SIBaseQuantities
import Quantities.SIPrefixes
import Quantities.SIBaseUnits
import Quantities.SIDerivedQuantities
import Quantities.NonSIUnits

%default total
%access public


-- Based on http://en.wikipedia.org/wiki/Imperial_units


-- Length

thou : ElemUnit Length
thou = < one "th" equals 25.4 (micro metre) >
th : ElemUnit Length
th = thou

inch : ElemUnit Length
inch = < one "in" equals 2.54 centimetre >
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

chain : ElemUnit Length
chain = < one "ch" equals 22 yard >
ch : ElemUnit Length
ch = chain

furlong : ElemUnit Length
furlong = < one "fur" equals 10 chain >
fur : ElemUnit Length
fur = furlong

mile : ElemUnit Length
mile = < one "mi" equals 1760 yard >
mi : ElemUnit Length
mi = mile

league : ElemUnit Length
league = < one "lea" equals 3 mile >
lea : ElemUnit Length
lea = league

-- Maritime units

fathom : ElemUnit Length
fathom = < one "ftm" equals 6.08 foot >
ftm : ElemUnit Length
ftm = fathom

cable : ElemUnit Length
cable = < one "cable" equals 608 foot >

nauticalMile : ElemUnit Length
nauticalMile = < one "nmi" equals 1852 metre >
nmi : ElemUnit Length
nmi = nauticalMile

-- Gunter's survey units

link : ElemUnit Length
link = < one "link" equals (1/100) chain >

rod : ElemUnit Length
rod = < one "rod" equals (1/4) chain >


-- Speed

knot : ElemUnit Speed
knot = < one "kn" equals 1 (nauticalMile <//> hour) >
kn : ElemUnit Speed
kn = knot


-- Area

perch : ElemUnit Area
perch = < one "perch" equals 1 (rod ^^ 2) >

rood : ElemUnit Area
rood = < one "rood" equals 1 (furlong <**> rod) >

acre : ElemUnit Area
acre = < one "acre" equals 1 (furlong <**> chain) >


-- Volume

fluidOunce : ElemUnit Volume
fluidOunce = < one "floz" equals 28.4130625 (milli $ (deci metre) ^^ 3) >
floz : ElemUnit Volume
floz = fluidOunce

gill : ElemUnit Volume
gill = < one "gi" equals 5 fluidOunce >
gi : ElemUnit Volume
gi = gill

pint : ElemUnit Volume
pint = < one "pt" equals 20 fluidOunce >
pt : ElemUnit Volume
pt = pint

quart : ElemUnit Volume
quart = < one "qt" equals 40 fluidOunce >
qt : ElemUnit Volume
qt = quart

gallon : ElemUnit Volume
gallon = < one "gal" equals 160 fluidOunce >
gal : ElemUnit Volume
gal = gallon

-- British apothecaries' volume measures

minim : ElemUnit Volume
minim = < one "min" equals 59.1938802083 (micro $ (deci metre) ^^ 3) >
min : ElemUnit Volume
min = minim

fluidScruple : ElemUnit Volume
fluidScruple = < one "fls" equals 20 minim >
fls : ElemUnit Volume
fls = fluidScruple

fluidDrachm : ElemUnit Volume
fluidDrachm = < one "fldr" equals 3 fluidScruple >
fldr : ElemUnit Volume
fldr = fluidDrachm


-- Mass

pound : ElemUnit Mass
pound = < one "lb" equals 453.59237 gram >
lb : ElemUnit Mass
lb = pound

grain : ElemUnit Mass
grain = < one "gr" equals (1/7000) pound >
gr : ElemUnit Mass
gr = grain

drachm : ElemUnit Mass
drachm = < one "dr" equals (1/256) pound >
dr : ElemUnit Mass
dr = drachm

ounce : ElemUnit Mass
ounce = < one "oz" equals (1/16) pound >
oz : ElemUnit Mass
oz = ounce

stone : ElemUnit Mass
stone = < one "st" equals 14 pound >
st : ElemUnit Mass
st = stone

quarter : ElemUnit Mass
quarter = < one "qtr" equals 28 pound >
qtr : ElemUnit Mass
qtr = quarter

hundredweight : ElemUnit Mass
hundredweight = < one "cwt" equals 112 pound >
cwt : ElemUnit Mass
cwt = hundredweight

ton : ElemUnit Mass
ton = < one "ton" equals 2240 pound >


-- Energy

footPound : ElemUnit Energy
footPound = < one "ftlb" equals 1 (foot <**> pound <**> g_0) >
ftlb : ElemUnit Energy
ftlb = footPound


-- Power

mechanicalHorsepower : ElemUnit Power
mechanicalHorsepower = < one "hp" equals 550 (footPound <//> second) >
imperialHorsepower : ElemUnit Power
imperialHorsepower = mechanicalHorsepower
horsepower : ElemUnit Power
horsepower = mechanicalHorsepower
hp : ElemUnit Power
hp = mechanicalHorsepower
