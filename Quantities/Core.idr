module Quantities.Core

import public Quantities.FreeAbelianGroup
import public Quantities.Power

%default total
%access public

||| Elementary quantities
record Dimension where
  constructor MkDimension
  name : String

implementation Eq Dimension where
  (MkDimension a) == (MkDimension b) = a == b

implementation Ord Dimension where
  compare (MkDimension a) (MkDimension b) = compare a b


-- Compound quantities

||| A quantity is a property that can be measured.
Quantity : Type
Quantity = FreeAbGrp Dimension

||| The trivial quantity
Scalar : Quantity
Scalar = unit

||| Create a new quantity.
mkQuantity : List (Dimension, Integer) -> Quantity
mkQuantity = mkFreeAbGrp

infixl 6 </>

-- Synonyms (quantites are multiplied, not added!)
||| Product quantity
(<*>) : Ord a => FreeAbGrp a -> FreeAbGrp a -> FreeAbGrp a
(<*>) = (<+>)
||| Quotient quantity
(</>) : Ord a => FreeAbGrp a -> FreeAbGrp a -> FreeAbGrp a
(</>) = (<->)

||| Convert dimensions to quantities
implicit
dimensionToQuantity : Dimension -> Quantity
dimensionToQuantity = inject


||| Elementary Unit
record ElemUnit (q : Quantity) where
  constructor MkElemUnit
  name : String
  conversionRate : Double

-- ElemUnit with its quantity hidden
ElemUnit' : Type
ElemUnit' = (q : Quantity ** ElemUnit q)

private
name' : ElemUnit' -> String
name' (q ** u) = name u

implementation Eq ElemUnit' where
  (q ** u) == (p ** v) = p == q && name u == name v

implementation Ord ElemUnit' where
  compare (q ** u) (p ** v) with (compare p q)
    | LT = LT
    | GT = GT
    | EQ = compare (name u) (name v)

implicit
elemUnitToElemUnit'FreeAbGrp : ElemUnit q -> FreeAbGrp ElemUnit'
elemUnitToElemUnit'FreeAbGrp {q} u = inject (q ** u)

conversionRate' : ElemUnit' -> Double
conversionRate' u = conversionRate (getProof u)

joinedQuantity : FreeAbGrp ElemUnit' -> Quantity
joinedQuantity = lift getWitness

data Unit : Quantity -> Type where
  MkUnit : (exponent : Integer) -> (elemUnits' : FreeAbGrp ElemUnit') ->
           Unit (joinedQuantity elemUnits')

rewriteUnit : r = q -> Unit q -> Unit r
rewriteUnit eq unit = rewrite eq in unit

base10Exponent : Unit q -> Integer
base10Exponent (MkUnit e _) = e

private
getElemUnits' : Unit q -> FreeAbGrp ElemUnit'
getElemUnits' (MkUnit _ us) = us

implementation Eq (Unit q) where
  x == y = base10Exponent x == base10Exponent y &&
           getElemUnits' x  == getElemUnits' y

||| The trivial unit
One : Unit Scalar
One = MkUnit 0 neutral

||| Multiples of ten
Ten : Unit Scalar
Ten = MkUnit 1 neutral

||| One hundredth
Percent : Unit Scalar
Percent = MkUnit (-2) neutral

||| One thousandth
Promille : Unit Scalar
Promille = MkUnit (-3) neutral

||| The trivial unit (synonymous with `one`)
UnitLess : Unit Scalar
UnitLess = One

implicit
elemUnitToUnit : {q : Quantity} -> ElemUnit q -> Unit q
elemUnitToUnit {q} u = rewriteUnit eq (MkUnit 0 (inject (q ** u)))
  where eq = really_believe_me (Refl {x=q})
  -- this should be:
  -- eq = sym (inject_lift_lem Prelude.Pairs.Sigma.getWitness (q ** u))
  -- but Idris doesn't accept this anymore since 0.9.18 and throws a
  -- unreadable type error :-(

||| Compute conversion factor from the given unit to the base unit of the
||| corresponding quantity.
joinedConversionRate : Unit q -> Double
joinedConversionRate (MkUnit e (MkFreeAbGrp us)) = fromUnits * fromExponent
  where fromUnits    = product $ map (\(u, i) => ((^) @{floatmultpower}) (conversionRate' u) i) us
        fromExponent = ((^) @{floatmultpower}) 10 e

||| Constructs a new unit given a name and conversion factor from an existing unit.
defineAsMultipleOf : String -> Double -> Unit q -> ElemUnit q
defineAsMultipleOf name factor unit = MkElemUnit name (factor * joinedConversionRate unit)

-- Syntax sugar for defining new units
syntax "< one" [name] equals [factor] [unit] ">" = defineAsMultipleOf name factor unit

implementation Show (Unit q) where
  show (MkUnit 0 (MkFreeAbGrp [])) = "unitLess"
  show (MkUnit e (MkFreeAbGrp [])) = "ten ^^ " ++ show e
  show (MkUnit e (MkFreeAbGrp (u :: us))) = if e == 0 then fromUnits
    else "ten ^^ " ++ show e ++ " <**> " ++ fromUnits
    where monom : (ElemUnit', Integer) -> String
          monom (unit, 1) = name' unit
          monom (unit, i) = name' unit ++ " ^^ " ++ show i
          fromUnits = monom u ++ concatMap ((" <**> " ++) . monom) us

||| Pretty-print a unit (using only ASCII characters)
showUnit : Unit q -> String
showUnit (MkUnit 0 (MkFreeAbGrp [])) = ""
showUnit (MkUnit e (MkFreeAbGrp [])) = "10^" ++ show e
showUnit (MkUnit e (MkFreeAbGrp (u :: us))) = if e == 0 then fromUnits
  else "10^" ++ show e ++ " " ++ fromUnits
  where monom : (ElemUnit', Integer) -> String
        monom (unit, 1) = name' unit
        monom (unit, i) = name' unit ++ "^" ++ show i
        fromUnits = monom u ++ concatMap ((" " ++) . monom) us

private
toSuperScript : Char -> Char
toSuperScript '1' = '¹'
toSuperScript '2' = '²'
toSuperScript '3' = '³'
toSuperScript '4' = '⁴'
toSuperScript '5' = '⁵'
toSuperScript '6' = '⁶'
toSuperScript '7' = '⁷'
toSuperScript '8' = '⁸'
toSuperScript '9' = '⁹'
toSuperScript '0' = '⁰'
toSuperScript '-' = '⁻'
toSuperScript x   = x

private
toSuper : String -> String
toSuper = pack . map toSuperScript . unpack

||| Pretty-print a unit
showUnitUnicode : Unit q -> String
showUnitUnicode (MkUnit 0 (MkFreeAbGrp [])) = ""
showUnitUnicode (MkUnit e (MkFreeAbGrp [])) = "10" ++ toSuper (show e)
showUnitUnicode (MkUnit e (MkFreeAbGrp (u :: us))) = if e == 0 then fromUnits
  else "10" ++ toSuper (show e) ++ " " ++ fromUnits
  where monom : (ElemUnit', Integer) -> String
        monom (unit, 1) = name' unit
        monom (unit, i) = name' unit ++ toSuper (show i)
        fromUnits = monom u ++ concatMap ((" " ++) . monom) us

infixr 10 ^^
||| Power unit
(^^) : Unit q -> (i : Integer) -> Unit (q ^ i)
(^^) (MkUnit e us) i = rewriteUnit eq (MkUnit (i*e) (us ^ i))
  where eq = really_believe_me (Refl {x=(lift Prelude.Pairs.Sigma.getWitness (us ^ i))})
  -- this should be:
  -- eq = sym (lift_power_lem Prelude.Pairs.Sigma.getWitness us i)
  -- but Idris doesn't accept this anymore since 0.9.18 and throws a
  -- unreadable type error :-(

||| Inverse unit (e.g. the inverse of `second` is `one <//> second` a.k.a. `hertz`)
unitInverse : Unit q -> Unit (inverse q)
unitInverse {q} u = rewrite (freeabgrppower_correct q (-1))
                    in u ^^ (-1)

infixl 6 <**>,<//>

||| Product unit
(<**>) : Unit r -> Unit s -> Unit (r <*> s)
(<**>) (MkUnit e rs) (MkUnit f ss) = rewriteUnit eq (MkUnit (e+f) (rs <*> ss))
  where eq = really_believe_me (Refl {x=(lift Prelude.Pairs.Sigma.getWitness (rs <*> ss))})
  -- this should be:
  -- eq = sym (lift_mult_lem Prelude.Pairs.Sigma.getWitness rs ss)
  -- but Idris doesn't accept this anymore since 0.9.18 and throws a
  -- unreadable type error :-(

||| Quotient unit
(<//>) : Unit r -> Unit s -> Unit (r </> s)
(<//>) a b = a <**> unitInverse b

infixl 5 =| -- sensible?
||| Numbers tagged with a unit
data Measurement : {q : Quantity} -> Unit q -> Type -> Type where
  (=|) : a -> (u : Unit q) -> Measurement u a

||| Extract the number
getValue : {q : Quantity} -> {u : Unit q} ->
           Measurement {q} u a -> a
getValue (x =| _) = x

implementation Functor (Measurement {q} u) where
  map f (x =| _) = f x =| u

implementation Eq a => Eq (Measurement {q} u a) where
  (x =| _) == (y =| _) = x == y

implementation Ord a => Ord (Measurement {q} u a) where
  compare (x =| _) (y =| _) = compare x y

implementation Show a => Show (Measurement {q} u a) where
  show (x =| _) = show x ++ " =| " ++ show u

implementation Num a => Semigroup (Measurement {q} u a) where
  (x =| _) <+> (y =| _) = (x + y) =| u

implementation Num a => Monoid (Measurement {q} u a) where
  neutral = fromInteger 0 =| u

implementation (Neg a, Num a) => Group (Measurement {q} u a) where
  inverse (x =| _) = (-x) =| u

implementation (Neg a, Num a) => AbelianGroup (Measurement {q} u a) where

||| Pretty-print a measurement (using only ASCII characters)
showMeasurement : Show a => {q : Quantity} -> {u : Unit q} ->
                  (Measurement u a) -> String
showMeasurement (x =| u) =
  show x ++ (if base10Exponent u == 0 then " " else "*") ++ showUnit u

||| Pretty-print a measurement (using only ASCII characters)
showMeasurementUnicode : Show a => {q : Quantity} -> {u : Unit q} ->
                         (Measurement u a) -> String
showMeasurementUnicode (x =| u) =
  show x ++ (if base10Exponent u == 0 then " " else "·") ++ showUnit u

infixl 5 :|

||| Type synonym for `Measurement`
(:|) : Unit q -> Type -> Type
(:|) = Measurement

||| Flatten nested measurements
joinUnits : {q : Quantity} -> {r : Quantity} -> {u : Unit q} -> {v : Unit r} ->
            (u :| (v :| a)) -> (u <**> v) :| a
joinUnits ((x =| v) =| u) = x =| (u <**> v)


||| Double with a unit
F : Unit q -> Type
F u = Measurement u Double


infixl 9 |*|,|/|

||| Product measurement
(|*|) : Num a => {q : Quantity} -> {r : Quantity} -> {u : Unit q} -> {v : Unit r} ->
        u :| a -> v :| a -> (u <**> v) :| a
(|*|) (x =| u) (y =| v) = (x*y) =| (u <**> v)

||| Quotient measurement (the second measurement mustn't be zero!)
(|/|) : {q : Quantity} -> {r : Quantity} -> {u : Unit q} -> {v : Unit r} ->
        F u -> F v -> F (u <//> v)
(|/|) (x =| u) (y =| v) = (x/y) =| (u <//> v)

infixl 10 |^|

||| Power measurement
(|^|) : {q : Quantity} -> {u : Unit q} -> F u -> (i : Integer) -> F (u ^^ i)
(|^|) (x =| u) i = (((^) @{floatmultpower}) x i) =| u ^^ i

||| Square root measurement
sqrt : {q : Quantity} -> {u : Unit q} -> F (u ^^ 2) -> F u
sqrt {q} {u} (x =| _) = (sqrt x) =| u

||| Round measurement to the next integer below
floor : {q : Quantity} -> {u : Unit q} -> F u -> F u
floor = map floor

||| Round measurement to the next integer above
ceiling : {q : Quantity} -> {u : Unit q} -> F u -> F u
ceiling = map ceiling

||| Convert measurements to a given unit
convertTo : {from : Unit q} -> (to : Unit q) -> F from -> F to
convertTo to (x =| from) = (x * (rateFrom / rateTo)) =| to
  where rateFrom = joinedConversionRate from
        rateTo   = joinedConversionRate to

||| Flipped version of `convertTo`
as : {from : Unit q} -> F from -> (to : Unit q) -> F to
as x u = convertTo u x

||| Convert with implicit target unit
convert : {from : Unit q} -> {to : Unit q} -> F from -> F to
convert {to=to} x = convertTo to x

||| Promote values to measurements of the trivial quantity
implicit
toUnitLess : a -> Measurement unitLess a
toUnitLess x = x =| unitLess

implementation Num a => Num (Measurement unitLess a) where
  x + y = (getValue x + getValue y) =| unitLess
  x * y = (getValue x * getValue y) =| unitLess
  fromInteger i = fromInteger i =| unitLess

implementation Neg a => Neg (Measurement unitLess a) where
  negate x = negate (getValue x) =| unitLess
  x - y = (getValue x - getValue y) =| unitLess
  abs x = abs (getValue x) =| unitLess
