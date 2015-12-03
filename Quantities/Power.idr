module Quantities.Power

--import Control.Algebra

infixr 10 ^

%default total
%access public


-- 'Group', '<->' and 'AbelianGroup' are copied from Control.Algebra from 'contrib'.
-- I didn't just include Control.Algebra, because 'idris --install quantities.ipkg'
-- didn't know where to find Control.Algebra. Specifying 'contrib' in libs in
-- the IPKG file didn't help either.

-- XXX: change?
infixl 6 <->

||| Sets equipped with a single binary operation that is associative, along with
||| a neutral element for that binary operation and inverses for all elements.
||| Must satisfy the following laws:
||| + Associativity of `<+>`:
|||     forall a b c, a <+> (b <+> c) == (a <+> b) <+> c
||| + Neutral for `<+>`:
|||     forall a,     a <+> neutral   == a
|||     forall a,     neutral <+> a   == a
||| + Inverse for `<+>`:
|||     forall a,     a <+> inverse a == neutral
|||     forall a,     inverse a <+> a == neutral
class Monoid a => Group a where
  inverse : a -> a

(<->) : Group a => a -> a -> a
(<->) left right = left <+> (inverse right)

class Group a => AbelianGroup a where { }


class Power a where
  (^) : a -> Integer -> a

class Power a => VerifiedPower a where
  iteratedPower : (x : a) -> (i : Integer) -> (j : Integer) ->
                  (x ^ i) ^ j = x ^ (i*j)

-- Inefficient. Use square and multiply!
private
grpPow : Group g => g -> g -> Nat -> g
grpPow _ y Z = y
grpPow x y (S k) = grpPow x (y <+> x) k

instance Group g => Power g where
  (^) a i = case compare i 0 of
    LT => grpPow (inverse a) neutral (fromIntegerNat (-i))
    _  => grpPow a neutral (fromIntegerNat i)

instance [floatmultpower] Power Double where
  a ^ 0 = fromInteger 1
  a ^ i = if a == 0 then 0 else case compare i 0 of
    LT => pow (1 / a) (fromIntegerNat (-i))
    _  => pow a (fromIntegerNat i)
