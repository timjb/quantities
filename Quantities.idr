module Quantities

import Quantities.FreeAbelianGroup

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
-- This should be abstract (but Quantities/Units doesn't compile then)
--data Quantity = MkQuantity (FreeAbGrp ElemQuantity)

Quantity : Type
Quantity = FreeAbGrp ElemQuantity

scalar : Quantity
scalar = unit

mkQuantity : List (ElemQuantity, Integer) -> Quantity
mkQuantity = mkFreeAbGrp

{-
instance Eq Quantity where
  (MkQuantity x) == (MkQuantity y) = x == y

instance Ord Quantity where
  compare (MkQuantity x) (MkQuantity y) = compare x y

instance Semigroup Quantity where
  (MkQuantity x) <+> (MkQuantity y) = MkQuantity (x <+> y)

instance VerifiedSemigroup Quantity where
  semigroupOpIsAssociative = ?todo

instance Monoid Quantity where
  neutral = scalar
-}

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

-- TODO: prove type correctness
implicit
elemUnitToUnit : {q : Quantity} -> ElemUnit q -> Unit q
elemUnitToUnit {q} u = rewrite (sym (inject_lift_lem getWitness (q ** u)))
                       in MkUnit (inject (q ** u))

private
joinedConversionRate : Unit q -> Float
joinedConversionRate (MkUnit (MkFreeAbGrp us)) =
  product $ map (\(u, i) => power (conversionRate' u) i) us
  where power : Float -> Integer -> Float
        power a i = case compare i 0 of
          LT => pow (1 / a) (fromIntegerNat (-i))
          _  => pow a (fromIntegerNat i)

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

infixl 9 |*|,|/|

(|*|) : Num a => {m : Quantity} -> {n : Quantity} -> {u : Unit m} -> {v : Unit n} ->
        Measurement u a -> Measurement v a -> Measurement (u <**> v) a
(|*|) (x =| u) (y =| v) = (x*y) =| (u <**> v)

(|/|) : {m : Quantity} -> {n : Quantity} -> {u : Unit m} -> {v : Unit n} ->
        Measurement u Float -> Measurement v Float -> Measurement (u <//> v) Float
(|/|) (x =| u) (y =| v) = (x/y) =| (u <//> v)

-- Floats with a unit
F : Unit q -> Type
F u = Measurement u Float

{-
-- Doubles with a unit
D : Unit q -> Type
D u = Measurement u Double
-}

convertTo : {from : Unit q} -> (to : Unit q) -> F from -> F to
convertTo to (x =| from) = (x * (rateFrom / rateTo)) =| to
  where rateFrom = joinedConversionRate from
        rateTo   = joinedConversionRate to

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
