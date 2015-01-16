module Documentation

import Quantities
import Quantities.NonSIUnits
import Quantities.ImperialUnits


Happiness : Dimension
Happiness = MkDimension "Happiness"

cubicCentimetre : Unit Volume
cubicCentimetre = centimetre ^^ 3

-- the quantity of happiness that a one kilogram beagle puppy whose body temperature is 310 kelvins produces when held in skin contact for one second
puppy : ElemUnit Happiness
puppy = MkElemUnit "puppy" 1

-- If you're like me …
kitten : ElemUnit Happiness
kitten = < one "kitten" equals 1.5 puppy >

distanceToMoon : F metre
distanceToMoon = 384400000.0 =| metre

distanceToMoonInMiles : F mile
distanceToMoonInMiles = convertTo mile distanceToMoon

-- According to Wikipedia
dogYear : ElemUnit Time
dogYear = < one "dy" equals 52 day >

myAgeInDogYears : F dogYear
myAgeInDogYears = (19 =| year) `as` dogYear
-- = 133.46 dy

weight : F kilogram
weight = 2 =| kilogram

height : F metre
height = 2 =| metre

duration : F second
duration = 0.8 =| second

g_0 : F (metre <//> (second ^^ 2))
g_0 = 9.80665 =| (metre <//> (second ^^ 2))

averagePower : F watt
averagePower = convert $ (weight |*| height |*| g_0) |/| duration

energyConversionEfficiency : Float
energyConversionEfficiency = 0.88

batteryCapacity : F (watt <**> hour)
batteryCapacity = 85000 =| (watt <**> hour)

usedEnergy : F (watt <**> hour)
usedEnergy = convert $ energyConversionEfficiency |*| batteryCapacity

eatChocolateCake : F puppy -> F puppy
eatChocolateCake x = x <+> (2 =| puppy)

microscopeResolution : F (nano metre)
microscopeResolution = 180 =| (nano metre)

performance : F (mega watt)
performance = 3.1 =| (mega watt)
