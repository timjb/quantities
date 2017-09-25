module Quantities.FreeAbelianGroup

import Quantities.Power

%default total
%access public export

mergeWithBy : (k -> k -> Ordering) -> (v -> v -> v) ->
              List (k, v) -> List (k, v) -> List (k, v)
mergeWithBy _ _ [] ys = ys
mergeWithBy _ _ xs [] = xs
mergeWithBy order combine ((k1, v1) :: xs) ((k2, v2) :: ys) = let o = order k1 k2 in
  if o == LT then (k1, v1) :: mergeWithBy order combine xs ((k2, v2) :: ys)
  else if o == GT then (k2, v2) :: mergeWithBy order combine ((k1, v1) :: xs) ys
  else (k1, combine v1 v2) :: mergeWithBy order combine xs ys

mergeWith : Ord k => (v -> v -> v) ->
            List (k, v) -> List (k, v) -> List (k, v)
mergeWith = mergeWithBy compare

filterValues : (v -> Bool) -> List (k, v) -> List (k, v)
filterValues p = filter (p . snd)

mapValue : (v -> w) -> List (k, v) -> List (k, w)
mapValue f = map (\(k, v) => (k, f v))

data FreeAbGrp : Type -> Type where
  MkFreeAbGrp : {a : Type} -> (List (a, Integer)) -> FreeAbGrp a

mkFreeAbGrp : Ord a => List (a, Integer) -> FreeAbGrp a
mkFreeAbGrp = MkFreeAbGrp . filterValues (\x => x /= 0)
                          . foldr (\x => mergeWith (+) [x]) []

unit : FreeAbGrp a
unit = MkFreeAbGrp []

implicit
inject : a -> FreeAbGrp a
inject x = MkFreeAbGrp [(x, 1)]

freeAbGrpPower : FreeAbGrp a -> Integer -> FreeAbGrp a
freeAbGrpPower _ 0 = unit
freeAbGrpPower (MkFreeAbGrp xs) i = MkFreeAbGrp $ mapValue (i*) xs

freeAbGrpInverse : FreeAbGrp a -> FreeAbGrp a
freeAbGrpInverse x = freeAbGrpPower x (-1)

infixl 6 <<+>>
(<<+>>) : Ord a => FreeAbGrp a -> FreeAbGrp a -> FreeAbGrp a
(MkFreeAbGrp xs) <<+>> (MkFreeAbGrp ys) = MkFreeAbGrp $ filterValues (\x => x /= 0) $ mergeWithBy compare (+) xs ys

implementation Eq a => Eq (FreeAbGrp a) where
  (MkFreeAbGrp xs) == (MkFreeAbGrp ys) = xs == ys

implementation Ord a => Ord (FreeAbGrp a) where
  compare (MkFreeAbGrp xs) (MkFreeAbGrp ys) = compare xs ys

implementation [freeabgrppower] Power (FreeAbGrp a) where
  (^) = freeAbGrpPower

implementation Ord a => Semigroup (FreeAbGrp a) where
  (<+>) = (<<+>>)

implementation Ord a => Monoid (FreeAbGrp a) where
  neutral = unit

implementation Ord a => Group (FreeAbGrp a) where
  inverse = freeAbGrpInverse

implementation Ord a => AbelianGroup (FreeAbGrp a) where

-- Lift a function A -> G to a group homomorphism between the freely generated
-- abelian group of A to the group G.
lift : (Group g, Power g) => (a -> g) -> FreeAbGrp a -> g
lift f (MkFreeAbGrp xs) = concatMap (\(x, i) => ((f x) ^ i)) xs

inject_lift_lem : (Group g, Power g) => (f : a -> g) -> (x : a) -> lift f (inject x) = f x
inject_lift_lem f x = really_believe_me (Refl {x=(lift f (inject x))})

lift_power_lem : (Group g, Power g, Ord a) => (f : a -> g) -> (x : FreeAbGrp a) ->
                 (i : Integer) -> lift f (x ^ i) = lift f x ^ i
lift_power_lem f x i = really_believe_me (Refl {x=(lift f (x ^ i))})

lift_mult_lem : (Ord a, Group g, Power g) => (f : a -> g) -> (x : FreeAbGrp a) ->
                (y : FreeAbGrp a) -> lift f (x <+> y) = lift f x <+> lift f y
lift_mult_lem f x y = really_believe_me (Refl {x=(lift f (x <+> y))})

freeabgrppower_correct : (Ord a) => (x : FreeAbGrp a) -> (i : Integer) -> freeAbGrpPower x i = (^) x i
freeabgrppower_correct x i = really_believe_me (Refl {x=(freeAbGrpPower x i)})
