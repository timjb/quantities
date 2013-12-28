# Quantities

Quantities is a library type-safe physical computations and unit conversions in Idris.

## Installation

Copy this package and run

```bash
$ idris --install quantities.ipkg
```
To use it in your program, run idris with

```bash
$ idris -p quantities yourprogram.idr
```

## Documentation

### Quantities

Quantities are physical properties that you can measure. They include length, speed, pressure, electric resistance, etc. We can multiply and devide quantities to form new quantities:

```haskell
Area : Quantity
Area = Length <*> Length

Speed : Quantity
Speed = Length </> Time

Volume : Quantity
Volume = Length ^ 3

Frequency : Quantity
Frequency = Time ^ (-1)
```

Above we defined the quantities `Area`, `Speed`, `Volume` and `Frequency` in terms of `Length` and `Time`. By convention, we write quantities with a capital letters.


### Dimensions

Of course, we can't derive all quantities from existing quantities, but have to start with some base quantities. The SI system of units defines `Length`, `Mass`, `Time`, `ElectricCurrent`, `Temperature`, `AmountOfSubstance` and `LuminousIntensity` as base quantities. We can declare like follows:

```haskell
Length : Dimension
Length = MkDimension "Length"

Time : Dimension
Time = MkDimension "Time"

Happiness : Dimension
Happiness = MkDimension "Happiness"
```

The `Quantity` datatype is now defined as the [free abelian group](http://en.wikipedia.org/wiki/Free_abelian_group) over the `Dimension` data type. There is a function, `dimensionToQuantity : Dimension -> Quantity`, which implicitly converts dimensions to quantities.


### Units

A unit represents a specific amount of a quantity. For example, w e have

```haskell
centimetre : Unit Length
second : Unit Time
ampere : Unit ElectricCurrent
newton : Unit Force
```

Notice that units are indexed by the quantity they represent. Like with quantities, we can multiply and devide units to derive new units. But there is a catch: when we multiply two units, the resulting unit represents the product of their respective quantities. For example, when we multiply the unit centimetre with itself, we get a unit for area, since `Area = Length <*> Length`. Therefore, we have the functions

```haskell
(<**>) : {q : Quantity} -> {r : Quantity} -> Unit q -> Unit r -> Unit (q <*> r)
(<//>) : {q : Quantity} -> {r : Quantity} -> Unit q -> Unit r -> Unit (q </> r)
(^^)   : {q : Quantity} -> Unit r -> (i : Integer) -> Unit (q ^ i)
```

For example:

```haskell
squareCentimetre : Unit Area
squareCentimetre = centimetre <*> centimetre -- = centimetre ^^ 2

metrePerSecond : Unit Speed
metrePerSecond = meter <//> second

cubicCentimetre : Unit Volume
cubicCentimetre = centimetre ^^ 3

newton : Unit ((Length <*> Mass) </> (Time ^ 2))
newton = (metre <**> kilogram) <//> (second ^^ 2)
```


### Elementary Units

We have to start somewhere by defining some base units:

```haskell
metre : ElemUnit Length
metre = MkElemUnit "m" 1

second : ElemUnit Time
second = MkElemUnit "s" 1

candela : ElemUnit LuminousIntensity
candela = MkElemUnit "cd" 1

-- the quantity of happiness that a one kilogram beagle puppy whose body temperature is 310 kelvins produces when held in skin contact for one second
puppy : ElemUnit Happiness
puppy = MkElemUnit "puppy" 1
```

These are called elementary units. The number at the end of `MkElemUnit` is used as a conversion rate to the base unit of the quantity. Since `metre`, `candela` and `puppy` are the base units themselves, the conversion rate for them is `1`. Which unit you consider as a base unit for a dimension isn't important as long as you stay consistent with your choices.

Elementary units are not just a way to bootstrap the system of units; they can also be used to define other units, with some syntax sugar:

```haskell
mile : ElemUnit Length
mile = < one "mile" equals 1609.344 metre >

-- Speed of light
c_0 : ElemUnit Speed
c_0 = < one "c_0" equals 299792458 (metre <//> second) >

-- If you're like me ...
kitten : ElemUnit Happiness
kitten = < one "kitten" equals 1.5 puppy >
```

Units are defined as the free abelian group over elementary units, with the addition that we keep track of the quantities that are represented by the units.

Elementary units are implicitly converted to units by the function

```haskell
elemUnitToUnit : {q : Quantity} -> ElemUnit q -> Unit q
```


### Measurements

Measurements are values tagged with a unit.

```haskell
data Measurement : {q : Quantity} -> Unit q -> Type -> Type where
  (=|) : a -> (u : Unit q) -> Measurement u a
```

Since `Measurement` is a bit long, there is a shorthand form: `u :| a` is the same as `Measurement u a`. For measurements with float values there is an even shorter alias:

```haskell
F : Unit q -> Type
F u = Measurement u Float
```

For example:

```haskell
distanceToMoon : F metre
distanceToMoon = 384400000.0 =| metre
```


### Converting between units

Sometimes, a conversion isn't necessary. For example, the unit `newton` is definitionally equal to `(metre <**> kilogram) <//> (second ^^ 2)`, so you won't have to convert between these. But generally, you will need a conversion function.

```haskell
distanceToMoonInMiles : F miles
distanceToMoonInMiles = convertTo miles distanceToMoon

-- According to Wikipedia
dogYear : ElemUnit Time
dogYear = < one "dy" equals 52 day >

myAgeInDogYears : F dogYear
myAgeInDogYears = (19 =| year) `as` dogYear
```

Since the target in the first example is clear from the context, we could write `convert` instead of `convertTo miles`. For reference, the conversion functions used above are

```haskell
convertTo : {from : Unit q} -> (to : Unit q) -> F from -> F to
convert : {from : Unit q} -> {to : Unit q} -> F from -> F to
as : {from : Unit q} -> F from -> (to : Unit q) -> F to
```


### Calculations with measurements

Let's say I've lifted a 5 kg weight from ground to a height of 2 metre in 0.8 seconds. What's the avarage power of this action?

```haskell
weight : F kilogram
weight = 2 =| kilogram

height : F metre
height = 2 =| metre

duration : F seconds
duration = 0.8 =| second

g_0 : F (metre <//> (second ^^ 2))
g_0 = 9.80665 =| (metre <//> (second ^^ 2))

averagePower : F watt
averagePower = convert $ (weight |*| height |*| g_0) |/| duration
-- = 
```

This example shows how to multiply measurements using the functions

```haskell
(|*|) : Num a => {u : Unit q} -> {v : Unit r} -> u :| a -> v :| a -> (u <**> v) :| a
(|/|) : {u : Unit q} -> {v : Unit r} -> F u -> F v -> F (u <//> v)
(|^|) : {u : Unit q} -> F u -> (i : Integer) -> F (u ^^ i)
(|*|)
```

We can even use these functions to multiply measurements with scalar values:

```haskell
energyConversionEfficiency : Float
energyConversionEfficiency = 0.88

batteryCapacity : F (watt <**> hour)
batteryCapacity = 85000 =| (watt <**> hour)

usedEnergy : F (watt <**> hour)
usedEnergy = convert $ energyConversionEfficiency |*| batteryCapacity
```

TODO: addition, reference


### Predefined quantities and units

TODO

### Prefixes

TODO

## Example

## License