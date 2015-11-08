module Documentation

import Quantities
import Quantities.NonSIUnits
import Quantities.ImperialUnits


Happiness : Dimension
Happiness = MkDimension "Happiness"

cubicCentimetre : Unit Volume
cubicCentimetre = Centimetre ^^ 3

-- the quantity of happiness that a one kilogram beagle puppy whose body temperature is 310 kelvins produces when held in skin contact for one second
Puppy : ElemUnit Happiness
Puppy = MkElemUnit "puppy" 1

-- If you're like me …
Kitten : ElemUnit Happiness
Kitten = < one "Kitten" equals 1.5 Puppy >

distanceToMoon : F Metre
distanceToMoon = 384400000.0 =| Metre

distanceToMoonInMiles : F Mile
distanceToMoonInMiles = convertTo Mile distanceToMoon

-- According to Wikipedia
DogYear : ElemUnit Time
DogYear = < one "dy" equals 52 Day >

myAgeInDogYears : F DogYear
myAgeInDogYears = (21 =| Year) `as` DogYear
-- = 133.46 dy

weight : F Kilogram
weight = 2 =| Kilogram

height : F Metre
height = 2 =| Metre

duration : F Second
duration = 0.8 =| Second

g_0 : F (Metre <//> (Second ^^ 2))
g_0 = 9.80665 =| (Metre <//> (Second ^^ 2))

averagePower : F Watt
averagePower = convert $ (weight |*| height |*| g_0) |/| duration

energyConversionEfficiency : F One
energyConversionEfficiency = 0.88 =| One

batteryCapacity : F (Watt <**> Hour)
batteryCapacity = 85000 =| (Watt <**> Hour)

usedEnergy : F (Watt <**> Hour)
usedEnergy = convert $ energyConversionEfficiency |*| batteryCapacity

eatChocolateCake : F Puppy -> F Puppy
eatChocolateCake x = x <+> (2 =| Puppy)

microscopeResolution : F (nano Metre)
microscopeResolution = 180 =| (nano Metre)

performance : F (mega Watt)
performance = 3.1 =| (mega Watt)
