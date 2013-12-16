module Quantities.FreeAbelianGroup

%default total
%access public


%assert_total
private
mergeWithBy : (k -> k -> Ordering) -> (v -> v -> v) ->
              List (k, v) -> List (k, v) -> List (k, v)
mergeWithBy _ _ [] ys = ys
mergeWithBy _ _ xs [] = xs
mergeWithBy order combine ((k1, v1) :: xs) ((k2, v2) :: ys) with (order k1 k2)
  | LT = (k1, v1) :: mergeWithBy order combine xs ((k2, v2) :: ys)
  | GT = (k2, v2) :: mergeWithBy order combine ((k1, v1) :: xs) ys
  | EQ = (k1, combine v1 v2) :: mergeWithBy order combine xs ys

private
mergeWith : Ord k => (v -> v -> v) ->
            List (k, v) -> List (k, v) -> List (k, v)
mergeWith = mergeWithBy compare

private
filterValues : (v -> Bool) -> List (k, v) -> List (k, v)
filterValues p = filter (p . snd)

--private
mapValue : (v -> w) -> List (k, v) -> List (k, w)
mapValue f = map (\(k, v) => (k, f v))


data FreeAbGrp a = MkFreeAbGrp (List (a, Integer))

mkFreeAbGrp : Ord a => List (a, Integer) -> FreeAbGrp a
mkFreeAbGrp = MkFreeAbGrp . filterValues (/= 0)
                          . foldr (\x => mergeWith (+) [x]) []

unit : FreeAbGrp a
unit = MkFreeAbGrp []

inject : a -> FreeAbGrp a
inject x = MkFreeAbGrp [(x, 1)]

infixr 7 ^

class Power a where
  (^) : a -> Integer -> a

-- Inefficient. Optimize!
private
grpPow : Group g => g -> g -> Nat -> g
grpPow _ y Z = y
grpPow x y (S k) = grpPow x (y <+> x) k

instance Group g => Power g where
  (^) a i = case compare i 0 of
    LT => grpPow (inverse a) neutral (fromIntegerNat (-i))
    _  => grpPow a neutral (fromIntegerNat i)

instance [freeabgrppower] Power (FreeAbGrp a) where
  (^) _ 0 = unit
  (^) (MkFreeAbGrp xs) i = MkFreeAbGrp $ mapValue (i*) xs

instance Eq a => Eq (FreeAbGrp a) where
  (MkFreeAbGrp xs) == (MkFreeAbGrp ys) = xs == ys

instance Ord a => Ord (FreeAbGrp a) where
  compare (MkFreeAbGrp xs) (MkFreeAbGrp ys) = compare xs ys

instance Ord a => Semigroup (FreeAbGrp a) where
  (MkFreeAbGrp xs) <+> (MkFreeAbGrp ys) =
    MkFreeAbGrp $ filterValues (/= 0) $ mergeWith (+) xs ys

instance Ord a => Monoid (FreeAbGrp a) where
  neutral = unit

instance Ord a => Group (FreeAbGrp a) where
  inverse = flip ((^) @{freeabgrppower}) (-1)

instance Ord a => AbelianGroup (FreeAbGrp a) where

lift : (Group g, Power g) => (a -> g) -> FreeAbGrp a -> g
lift f (MkFreeAbGrp xs) = concatMap (\(x, i) => ((f x) ^ i)) xs

{-
instance VerifiedMonoid Quantity where
  monoidNeutralIsNeutralL l = ?neutralL --proof { compute; trivial; }
  monoidNeutralIsNeutralR r = ?neutralR --proof { compute; trivial; }
-}
