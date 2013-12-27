module Quantities.Information

import Quantities

Information : Dimension
Information = MkDimension "Information"

bit : ElemUnit Information
bit = MkElemUnit "bit" 1

byte : ElemUnit Information
byte = < one "byte" equals 8 bit >

-- Binary prefixes for multiples of bits/bytes
-- Based on http://en.wikipedia.org/wiki/Binary_prefix

private
twoToTheTen : String -> Nat -> ElemUnit q -> ElemUnit q
twoToTheTen pre power (MkElemUnit name f) =
  < one (pre ++ name) equals (pow 1024.0 power) (MkElemUnit name f) >

kibi : ElemUnit q -> ElemUnit q
kibi = twoToTheTen "kibi" 1
Ki : ElemUnit q -> ElemUnit q
Ki = kibi

mebi : ElemUnit q -> ElemUnit q
mebi = twoToTheTen "mebi" 2
Mi : ElemUnit q -> ElemUnit q
Mi = mebi

gibi : ElemUnit q -> ElemUnit q
gibi = twoToTheTen "gibi" 3
Gi : ElemUnit q -> ElemUnit q
Gi = gibi

tebi : ElemUnit q -> ElemUnit q
tebi = twoToTheTen "tebi" 4
Ti : ElemUnit q -> ElemUnit q
Ti = tebi

pebi : ElemUnit q -> ElemUnit q
pebi = twoToTheTen "pebi" 5
Pi : ElemUnit q -> ElemUnit q
Pi = pebi

exbi : ElemUnit q -> ElemUnit q
exbi = twoToTheTen "exbi" 6
Ei : ElemUnit q -> ElemUnit q
Ei = exbi

zebi : ElemUnit q -> ElemUnit q
zebi = twoToTheTen "zebi" 7
Zi : ElemUnit q -> ElemUnit q
Zi = zebi

yobi : ElemUnit q -> ElemUnit q
yobi = twoToTheTen "yobi" 8
Yi : ElemUnit q -> ElemUnit q
Yi = yobi

-- Please Note: kibi byte /= kilo byte
