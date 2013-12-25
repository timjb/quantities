module Quantities.Power

infixr 10 ^

%default total
%access public


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

instance [floatmultpower] Power Float where
  a ^ 0 = fromInteger 0
  a ^ i = if a == 0 then 0 else case compare i 0 of
    LT => pow (1 / a) (fromIntegerNat (-i))
    _  => pow a (fromIntegerNat i)
