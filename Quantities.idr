module Quantities

import Quantities.FreeAbelianGroup
import Data.Floats

%default total
%access public


-- Elementary quantities
record ElemQuantity : Type where
  MkElemQuantity : (name : String) -> ElemQuantity

instance Eq ElemQuantity where
  (MkElemQuantity a) == (MkElemQuantity b) = a == b

instance Ord ElemQuantity where
  compare (MkElemQuantity a) (MkElemQuantity b) = compare a b


-- Compound quantities

Quantity : Type
Quantity = FreeAbGrp ElemQuantity

scalar : Quantity
scalar = unit

mkQuantity : List (ElemQuantity, Integer) -> Quantity
mkQuantity = mkFreeAbGrp

-- Synonyms (quantites are multiplied, not added!)
infixl 6 <*>
infixl 6 </>

(<*>) : Ord a => FreeAbGrp a -> FreeAbGrp a -> FreeAbGrp a
(<*>) = (<+>)
(</>) : Ord a => FreeAbGrp a -> FreeAbGrp a -> FreeAbGrp a
(</>) = (<->)

implicit
elemQuantityToQuantity : ElemQuantity -> Quantity
elemQuantityToQuantity = inject


-- Elementary Units
record ElemUnit : Quantity -> Type where
  MkElemUnit : {q : Quantity} ->
               (name : String) ->
               (conversionRate : Float) -> ElemUnit q

multiplyElemUnit : String -> Float -> ElemUnit q -> ElemUnit q
multiplyElemUnit n f (MkElemUnit _ g) = MkElemUnit n (f * g)

syntax one [name] is [factor] [unit] = multiplyElemUnit name factor unit


-- ElemUnit with its quantity hidden
ElemUnit' : Type
ElemUnit' = (q : Quantity ** ElemUnit q)

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
  MkUnit : (us : FreeAbGrp ElemUnit') -> Unit (joinedQuantity us)

unitLess : Unit scalar
unitLess = MkUnit neutral

implicit
elemUnitToUnit : {q : Quantity} -> ElemUnit q -> Unit q
elemUnitToUnit {q} u = rewrite (sym (inject_lift_lem getWitness (q ** u)))
                       in MkUnit (inject (q ** u))

private
joinedConversionRate : Unit q -> Float
joinedConversionRate (MkUnit (MkFreeAbGrp us)) =
  product $ map (\(u, i) => ((^) @{floatmultpower}) (conversionRate' u) i) us

infixl 6 <**>

(<**>) : Unit r -> Unit s -> Unit (r <*> s)
(<**>) (MkUnit rs) (MkUnit ss) = rewrite (sym (lift_mult_lem getWitness rs ss))
                                 in MkUnit (rs <*> ss)

infixr 10 ^^

(^^) : Unit q -> (i : Integer) -> Unit (q ^ i)
(^^) (MkUnit us) i = rewrite (sym (lift_power_lem getWitness us i))
                     in MkUnit (us ^ i)

unitInverse : Unit q -> Unit (inverse q)
unitInverse {q} u = rewrite (freeabgrppower_correct q (-1))
                    in u ^^ (-1)

infixl 6 <//>

(<//>) : Unit r -> Unit s -> Unit (r </> s)
(<//>) a b = a <**> unitInverse b

-- Values with a unit
infixl 5 =| -- sensible?
data Measurement : {q : Quantity} -> Unit q -> Type -> Type where
  (=|) : a -> (u : Unit q) -> Measurement u a

instance Functor (Measurement {q} u) where
  map f (x =| _) = f x =| u

instance Eq a => Eq (Measurement {q} u a) where
  (x =| _) == (y =| _) = x == y

instance Ord a => Ord (Measurement {q} u a) where
  compare (x =| _) (y =| _) = compare x y

-- TODO: show unit
instance Show a => Show (Measurement {q} u a) where
  show (x =| _) = show x

instance Num a => Semigroup (Measurement {q} u a) where
  (x =| _) <+> (y =| _) = (x + y) =| u

instance Num a => Monoid (Measurement {q} u a) where
  neutral = fromInteger 0 =| u

instance Num a => Group (Measurement {q} u a) where
  inverse (x =| _) = (-x) =| u

instance Num a => AbelianGroup (Measurement {q} u a) where

-- TODO: is this sensible?
infixl 5 :|

(:|) : Unit q -> Type -> Type
(:|) = Measurement

joinUnits : {q : Quantity} -> {r : Quantity} -> {u : Unit q} -> {v : Unit r} ->
            (u :| (v :| a)) -> (u <**> v) :| a
joinUnits ((x =| v) =| u) = x =| (u <**> v)


-- Floats with a unit
F : Unit q -> Type
F u = Measurement u Float


infixl 9 |*|,|/|

(|*|) : Num a => {q : Quantity} -> {r : Quantity} -> {u : Unit q} -> {v : Unit r} ->
        u :| a -> v :| a -> (u <**> v) :| a
(|*|) (x =| u) (y =| v) = (x*y) =| (u <**> v)

(|/|) : {q : Quantity} -> {r : Quantity} -> {u : Unit q} -> {v : Unit r} ->
        F u -> F v -> F (u <//> v)
(|/|) (x =| u) (y =| v) = (x/y) =| (u <//> v)

infixl 10 |^|

(|^|) : {q : Quantity} -> {u : Unit q} -> F u -> (i : Integer) -> F (u ^^ i)
(|^|) (x =| u) i = (((^) @{floatmultpower}) x i) =| u ^^ i

sqrt : {q : Quantity} -> {u : Unit q} -> F (u ^^ 2) -> F u
sqrt {q} {u} (x =| _) = (sqrt x) =| u

floor : {q : Quantity} -> {u : Unit q} -> F u -> F u
floor = map floor

ceiling : {q : Quantity} -> {u : Unit q} -> F u -> F u
ceiling = map ceiling

convertTo : {from : Unit q} -> (to : Unit q) -> F from -> F to
convertTo to (x =| from) = (x * (rateFrom / rateTo)) =| to
  where rateFrom = joinedConversionRate from
        rateTo   = joinedConversionRate to

implicit
toUnitLess : a -> Measurement unitLess a
toUnitLess x = x =| unitLess

instance Num a => Num (unitLess :| a) where
  (x =| _) + (y =| _) = (x+y) =| unitLess
  (x =| _) - (y =| _) = (x-y) =| unitLess
  (x =| _) * (y =| _) = (x*y) =| unitLess
  abs (x =| _)        = abs x =| unitLess
  fromInteger i       = fromInteger i =| unitLess


-- Example:
-- convertTo ms (50 =| kmh)

{-
kilo : Unit a -> Unit a
kilo = multiplyUnit 1000

deci : Unit a -> Unit a
deci = multiplyUnit 0.1

centi : Unit a -> Unit a
centi = multiplyUnit 0.01

milli : Unit a -> Unit a
milli = multiplyUnit 0.001
-}
