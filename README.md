# Quantities [![Build Status](https://travis-ci.org/timjb/quantities.svg?branch=master)](https://travis-ci.org/timjb/quantities)

Quantities is a library for type-safe physical computations and unit conversions in Idris.

![New Cuyama](images/new-cuyama.jpg)

([Population Explosion!](http://www.flickr.com/photos/7-how-7/4139229048/in/photolist-7iLCA5-7k6s5z-7kan7d-9qNAwp-byuLp3-byuL93-7LTGBJ-9qNAMV-7LRM7r-hUvGJ3-7LK1as-7LJRRh-7LJZuN-7LF4UF-7LK2q5-7LTL3L-7LF2VD-7LJSsf-7LLNXx-7LQL5A-7LQMJY-7LTFgo-7LLLya-7LPJ4n-7LTEAJ-7LLMVX-7LRLu4-7RxVet-7Q9PPZ-7LLM2P-7LMFkF-7LRPFK-7LTJEN-7LNtL6-7LRAjs-7LLL6V-7LSqZJ-7LVMcC-7LRMNa-7LNsda-7LMzHt-7LMApk-7LTDZ9-7LRKHH-7LQK77-7LMBKH-7LRNtX-7QX1rM-7RxV5p-7QX1sx-7LRB1J/) by [7-how-7](http://www.flickr.com/photos/7-how-7/) &ndash; sign first seen on Andrew Kennedy's [Units-of-Measure page](http://research.microsoft.com/en-us/um/people/akenn/units/))

I'm collecting links on types and units of measures in the [wiki](https://github.com/timjb/quantities/wiki/Links). If you know an interesting project, paper etc. you're invited to add it to the list!

## Installation

Copy this package and run

```bash
$ idris --install quantities.ipkg
```
To use it in your program, run Idris with

```bash
$ idris -p quantities yourprogram.idr
```

**Compatibility: Tested with Idris 1.1.1**

## Documentation

### Quantities

Quantities are physical properties that you can measure. They include length, speed, pressure, electric resistance, etc. We can multiply and divide quantities to form new quantities:

```idris
Area : Quantity
Area = Length <*> Length

Speed : Quantity
Speed = Length </> Time

Volume : Quantity
Volume = Length ^ 3

Frequency : Quantity
Frequency = Time ^ (-1)
```

Above we defined the quantities `Area`, `Speed`, `Volume` and `Frequency` in terms of `Length` and `Time`. By convention, we write quantities with capital letters.


### Dimensions

Of course, we can't derive all quantities from existing quantities, but have to start with some base quantities. The SI system of units defines `Length`, `Mass`, `Time`, `ElectricCurrent`, `Temperature`, `AmountOfSubstance` and `LuminousIntensity` as base quantities. We can declare them like this:

```idris
Length : Dimension
Length = MkDimension "Length"

Time : Dimension
Time = MkDimension "Time"

Happiness : Dimension
Happiness = MkDimension "Happiness"
```

The `Quantity` data type is now defined as the [free abelian group](http://en.wikipedia.org/wiki/Free_abelian_group) over the `Dimension` data type. There is a function, `dimensionToQuantity : Dimension -> Quantity`, which implicitly converts dimensions to quantities.


### Units

A unit represents a specific amount of a quantity. For example, we have

```idris
Centimetre : Unit Length
Second : Unit Time
Ampere : Unit ElectricCurrent
Newton : Unit Force
```

Notice that units are indexed by the quantity they represent. Like with quantities, we can multiply and devide units to derive new units. But there is a catch: when we multiply two units, the resulting unit represents the product of their respective quantities. For example, when we multiply the unit `Centimetre` with itself, we get a unit for area, since `Area = Length <*> Length`. Therefore, we have the functions

```idris
(<**>) : {q : Quantity} -> {r : Quantity} -> Unit q -> Unit r -> Unit (q <*> r)
(<//>) : {q : Quantity} -> {r : Quantity} -> Unit q -> Unit r -> Unit (q </> r)
(^^)   : {q : Quantity} -> Unit r -> (i : Integer) -> Unit (q ^ i)
```

For example:

```idris
SquareCentimetre : Unit Area
SquareCentimetre = Centimetre <**> Centimetre -- = Centimetre ^^ 2

MetrePerSecond : Unit Speed
MetrePerSecond = Meter <//> Second

CubicCentimetre : Unit Volume
CubicCentimetre = Centimetre ^^ 3

Newton : Unit ((Length <*> Mass) </> (Time ^ 2))
Newton = (Metre <**> Kilogram) <//> (Second ^^ 2)
```


### Elementary Units

We have to start somewhere by defining some base units:

```idris
Metre : ElemUnit Length
Metre = MkElemUnit "m" 1

Second : ElemUnit Time
Second = MkElemUnit "s" 1

Candela : ElemUnit LuminousIntensity
Candela = MkElemUnit "cd" 1

-- the quantity of happiness that a one kilogram beagle puppy whose body temperature is 310 kelvins produces when held in skin contact for one second
Puppy : ElemUnit Happiness
Puppy = MkElemUnit "puppy" 1
```

These are called elementary units. The number at the end of `MkElemUnit` is the conversion rate to the base unit of the quantity. Since `Metre`, `Candela` and `Puppy` are the base units themselves, the conversion rate for them is `1`. Which unit you consider as a base unit for a dimension isn't important as long as you stay consistent with your choices.

Elementary units are not just a way to bootstrap the system of units; they can also be used to define other units, with some syntax sugar:

```idris
Mile : ElemUnit Length
Mile = < one "mile" equals 1609.344 Metre >

-- Speed of light
C_0 : ElemUnit Speed
C_0 = < one "c_0" equals 299792458 (Metre <//> Second) >

-- If you're like me ...
Kitten : ElemUnit Happiness
Kitten = < one "kitten" equals 1.5 Puppy >
```

Units are defined as the free abelian group over elementary units, with the addition that we keep track of the quantities that are represented by the units.

Elementary units are implicitly converted to units by the function

```idris
elemUnitToUnit : {q : Quantity} -> ElemUnit q -> Unit q
```


### Measurements

Measurements are values tagged with a unit.

```idris
data Measurement : {q : Quantity} -> Unit q -> Type -> Type where
  (=|) : a -> (u : Unit q) -> Measurement u a
```

Since `Measurement` is a bit long, there is a shorthand form: `u :| a` is the same as `Measurement u a`. For measurements with float values there is an even shorter alias:

```idris
F : Unit q -> Type
F u = Measurement u Float
```

For example:

```idris
distanceToMoon : F Metre
distanceToMoon = 384400000.0 =| Metre
```


### Converting between units

Sometimes, a conversion isn't necessary. For example, the unit `Newton` is definitionally equal to `(Metre <**> Kilogram) <//> (Second ^^ 2)`, so you won't have to convert between these. But generally, you will need a conversion function.

```idris
distanceToMoonInMiles : F miles
distanceToMoonInMiles = convertTo Mile distanceToMoon

-- According to Wikipedia
DogYear : ElemUnit Time
DogYear = < one "dy" equals 52 Day >

myAgeInDogYears : F DogYear
myAgeInDogYears = (21 =| Year) `as` DogYear
```

Since the target unit in the first example is clear from the context, we could write `convert` instead of `convertTo Mile`. For reference, the conversion functions used above are

```idris
convertTo : {from : Unit q} -> (to : Unit q) -> F from -> F to
convert   : {from : Unit q} -> {to : Unit q} -> F from -> F to
as        : {from : Unit q} -> F from -> (to : Unit q) -> F to
```


### Calculations with measurements

Let's say I've lifted a 5 kg weight from ground to a height of 2 metre in 0.8 seconds. What's the average power of this action?

```idris
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
-- = 49.033 Watt
```

This example shows how to multiply measurements using the functions

```idris
(|*|) : Num a => {u : Unit q} -> {v : Unit r} -> u :| a -> v :| a -> (u <**> v) :| a
(|/|) : {u : Unit q} -> {v : Unit r} -> F u -> F v -> F (u <//> v)
(|^|) : {u : Unit q} -> F u -> (i : Integer) -> F (u ^^ i)
```

We can even use these functions to multiply measurements with scalar values:

```idris
energyConversionEfficiency : F One
energyConversionEfficiency = 0.88 =| One

batteryCapacity : F (Watt <**> Hour)
batteryCapacity = 85000 =| (Watt <**> Hour)

usedEnergy : F (Watt <**> Hour)
usedEnergy = convert $ energyConversionEfficiency |*| batteryCapacity
```

We can add and subtract measurements, too, but only if they have the same unit:

```idris
(<+>) : Num a => Measurement u a -> Measurement u a -> Measurement u a
(<->) : Num a => Measurement u a -> Measurement u a -> Measurement u a
```

For example:

```idris
eatChocolateCake : F Puppy -> F Puppy
eatChocolateCake x = x <+> (2 =| Puppy)
```


### Predefined quantities and units

The library comes with many quantities and units predefined.

From the [International System of Units (SI)](http://en.wikipedia.org/wiki/International_System_of_Units):

* [`Quantities.SIBaseQuantities`](https://github.com/timjb/quantities/blob/master/Quantities/SIBaseQuantities.idr): The seven SI base quantities `Length`, `Mass`, `Time`, `ElectricCurrent`, `Temperature`, `LuminousIntensity` and `AmountOfSubstance`
* [`Quantities.SIDerivedQuantities`](https://github.com/timjb/quantities/blob/master/Quantities/SIDerivedQuantities.idr): SI derived quantites, e.g. `Velocity`, `Acceleration`, `ElectricResistance`, `Energy`, etc.
* [`Quantities.SIBaseUnits`](https://github.com/timjb/quantities/blob/master/Quantities/SIBaseUnits.idr): The base units corresponding to the base quantities: `Meter`, `Kilogram`, `Second`, `Ampere`, `Kelvin`, `Candela` and `Mole`
* [`Quantities.SIDerivedUnits`](https://github.com/timjb/quantities/blob/master/Quantities/SIDerivedUnits.idr): Various units derived from the seven base units, e.g. `Joule`, `Pascal`, `Ohm`, `Hertz`

These four modules are reexported by the main module [`Quantities`](https://github.com/timjb/quantities/blob/master/Quantities.idr).

Other quantities and units:

* [`Quantities.ImperialUnits`](https://github.com/timjb/quantities/blob/master/Quantities/ImperialUnits.idr): Imperial units, e.g. `Mile`, `Inch`, `Gallon`, `Pound`
* [`Quantities.NonSIUnits`](https://github.com/timjb/quantities/blob/master/Quantities/NonSIUnits.idr): Various common and uncommon units, e.g. `Minute`, `Electronvolt`, `Calorie`, `Tonne`, `LightYear`
* [`Quantities.Information`](https://github.com/timjb/quantities/blob/master/Quantities/Information.idr): Contains the quantity `Information` and its units `Bit` and `Bytes` with their various [binary prefixes](http://en.wikipedia.org/wiki/Binary_prefix), e.g. `mebi Byte` for 1024^2 bytes.
* [`Quantities.Screen`](https://github.com/timjb/quantities/blob/master/Quantities/Screen.idr): The quantity `ScreenLength` with the unit `Pixel`. Useful for UI programming.


### Metric Prefixes

All standard [SI prefixes](http://en.wikipedia.org/wiki/Metric_prefix) are supported. For example:

```idris
import Quantities

microscopeResolution : F (nano Metre)
microscopeResolution = 180 =| (nano Metre)

performance : F (mega Watt)
performance = 3.1 =| (mega Watt)
```


## Example

A simple example that demonstrates how one could use quantities to implement simple movement with gravity in a game.

```idris
module Game

import Quantities
import Quantities.Screen

ScreenSpeed : Quantity
ScreenSpeed = ScreenLength </> Time

Pxs : Unit ScreenSpeed
Pxs = Pixel <//> Second

record PlayerState where
  constructor MkPlayerState
  xSpeed : F Pxs
  ySpeed : F Pxs
  xPos   : F Px
  yPos   : F Px

gravity : Quantities.Core.F (Pxs <//> Second)
gravity = -800 =| (Pxs <//> Second)

-- Update player position and speed after a given duration
updatePlayerState : F Second -> PlayerState -> PlayerState
updatePlayerState dt (MkPlayerState xs ys xp yp) =
  let newYPos = yp <+> ys |*| dt
  in if newYPos <= (0 =| Px)
       then MkPlayerState (0 =| Pxs) (0 =| Pxs) xp (0 =| Px)
       else MkPlayerState xs (ys <+> gravity |*| dt)
                          (xp <+> xs |*| dt) newYPos
```

## Contributing

Feedback and pull requests adding code and units are welcome!
