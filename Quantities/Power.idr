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
