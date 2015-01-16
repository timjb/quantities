module Quantities.Core

import public Quantities.FreeAbelianGroup
import public Quantities.Power
import Data.Floats

%default total
%access public

||| Elementary quantities
record Dimension : Type where
  MkDimension : (name : String) -> Dimension

instance Eq Dimension where
  (MkDimension a) == (MkDimension b) = a == b

instance Ord Dimension where
  compare (MkDimension a) (MkDimension b) = compare a b


-- Compound quantities

||| A quantity is a property that can be measured.
Quantity : Type
Quantity = FreeAbGrp Dimension

||| The trivial quantity
scalar : Quantity
scalar = unit

||| Create a new quantity.
mkQuantity : List (Dimension, Integer) -> Quantity
mkQuantity = mkFreeAbGrp

infixl 6 <*>
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
record ElemUnit : Quantity -> Type where
  MkElemUnit : {q : Quantity} ->
               (name : String) ->
               (conversionRate : Float) -> ElemUnit q


-- ElemUnit with its quantity hidden
ElemUnit' : Type
ElemUnit' = (q : Quantity ** ElemUnit q)

private
name' : ElemUnit' -> String
name' (q ** u) = name u

instance Eq ElemUnit' where
  (q ** u) == (p ** v) = p == q && name u == name v

instance Ord ElemUnit' where
  compare (q ** u) (p ** v) with (compare p q)
    | LT = LT
    | GT = GT
    | EQ = compare (name u) (name v)

implicit
elemUnitToElemUnit'FreeAbGrp : ElemUnit q -> FreeAbGrp ElemUnit'
elemUnitToElemUnit'FreeAbGrp {q} u = inject (q ** u)

conversionRate' : ElemUnit' -> Float
conversionRate' u = conversionRate (getProof u)

joinedQuantity : FreeAbGrp ElemUnit' -> Quantity
joinedQuantity = lift getWitness

data Unit : Quantity -> Type where
  MkUnit : (exponent : Integer) -> (elemUnits' : FreeAbGrp ElemUnit') ->
           Unit (joinedQuantity elemUnits')

base10Exponent : Unit q -> Integer
base10Exponent (MkUnit e _) = e

private
getElemUnits' : Unit q -> FreeAbGrp ElemUnit'
getElemUnits' (MkUnit _ us) = us

instance Eq (Unit q) where
  x == y = base10Exponent x == base10Exponent y &&
           getElemUnits' x  == getElemUnits' y

||| The trivial unit
one : Unit scalar
one = MkUnit 0 neutral

||| Multiples of ten
ten : Unit scalar
ten = MkUnit 1 neutral

||| One hundredth
percent : Unit scalar
percent = MkUnit (-2) neutral

||| One thousandth
promille : Unit scalar
promille = MkUnit (-3) neutral

||| The trivial unit (synonymous with `one`)
unitLess : Unit scalar
unitLess = one

implicit
elemUnitToUnit : {q : Quantity} -> ElemUnit q -> Unit q
elemUnitToUnit {q} u = rewrite (sym (inject_lift_lem getWitness (q ** u)))
                       in MkUnit 0 (inject (q ** u))

||| Compute conversion factor from the given unit to the base unit of the
||| corresponding quantity.
joinedConversionRate : Unit q -> Float
joinedConversionRate (MkUnit e (MkFreeAbGrp us)) = fromUnits * fromExponent
  where fromUnits    = product $ map (\(u, i) => ((^) @{floatmultpower}) (conversionRate' u) i) us
        fromExponent = ((^) @{floatmultpower}) 10 e

||| Constructs a new unit given a name and conversion factor from an existing unit.
defineAsMultipleOf : String -> Float -> Unit q -> ElemUnit q
defineAsMultipleOf name factor unit = MkElemUnit name (factor * joinedConversionRate unit)

-- Syntax sugar for defining new units
syntax "< one" [name] equals [factor] [unit] ">" = defineAsMultipleOf name factor unit

instance Show (Unit q) where
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
(^^) (MkUnit e us) i = rewrite (sym (lift_power_lem getWitness us i))
                       in MkUnit (i*e) (us ^ i)

||| Inverse unit (e.g. the inverse of `second` is `one <//> second` a.k.a. `hertz`)
unitInverse : Unit q -> Unit (inverse q)
unitInverse {q} u = rewrite (freeabgrppower_correct q (-1))
                    in u ^^ (-1)

infixl 6 <**>,<//>

||| Product unit
(<**>) : Unit r -> Unit s -> Unit (r <*> s)
(<**>) (MkUnit e rs) (MkUnit f ss) = rewrite (sym (lift_mult_lem getWitness rs ss))
                                     in MkUnit (e+f) (rs <*> ss)

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

instance Functor (Measurement {q} u) where
  map f (x =| _) = f x =| u

instance Eq a => Eq (Measurement {q} u a) where
  (x =| _) == (y =| _) = x == y

instance Ord a => Ord (Measurement {q} u a) where
  compare (x =| _) (y =| _) = compare x y

instance Show a => Show (Measurement {q} u a) where
  show (x =| _) = show x ++ " =| " ++ show u

instance Num a => Semigroup (Measurement {q} u a) where
  (x =| _) <+> (y =| _) = (x + y) =| u

instance Num a => Monoid (Measurement {q} u a) where
  neutral = fromInteger 0 =| u

instance (Neg a, Num a) => Group (Measurement {q} u a) where
  inverse (x =| _) = (-x) =| u

instance (Neg a, Num a) => AbelianGroup (Measurement {q} u a) where

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


||| Floats with a unit
F : Unit q -> Type
F u = Measurement u Float


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
floor = map Data.Floats.floor

||| Round measurement to the next integer above
ceiling : {q : Quantity} -> {u : Unit q} -> F u -> F u
ceiling = map Data.Floats.ceiling

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

instance Num a => Num (Measurement unitLess a) where
  x + y = (getValue x + getValue y) =| unitLess
  x - y = (getValue x - getValue y) =| unitLess
  x * y = (getValue x * getValue y) =| unitLess
  abs x = abs (getValue x) =| unitLess
  fromInteger i = fromInteger i =| unitLess
