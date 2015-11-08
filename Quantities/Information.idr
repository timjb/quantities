module Quantities.Information

import Quantities.Core

Information : Dimension
Information = MkDimension "Information"

Bit : ElemUnit Information
Bit = MkElemUnit "bit" 1

Byte : ElemUnit Information
Byte = < one "byte" equals 8 Bit >

-- Binary prefixes for multiples of bits/bytes
-- Based on http://en.wikipedia.org/wiki/Binary_prefix

private
twoToTheTen : String -> Nat -> ElemUnit q -> ElemUnit q
twoToTheTen pre power (MkElemUnit name f) =
  < one (pre ++ name) equals (pow 1024.0 power) (MkElemUnit name f) >

kibi : ElemUnit q -> ElemUnit q
kibi = twoToTheTen "kibi" 1
ki : ElemUnit q -> ElemUnit q
ki = kibi

mebi : ElemUnit q -> ElemUnit q
mebi = twoToTheTen "mebi" 2
mi : ElemUnit q -> ElemUnit q
mi = mebi

gibi : ElemUnit q -> ElemUnit q
gibi = twoToTheTen "gibi" 3
gi : ElemUnit q -> ElemUnit q
gi = gibi

tebi : ElemUnit q -> ElemUnit q
tebi = twoToTheTen "tebi" 4
ti : ElemUnit q -> ElemUnit q
ti = tebi

pebi : ElemUnit q -> ElemUnit q
pebi = twoToTheTen "pebi" 5
pi : ElemUnit q -> ElemUnit q
pi = pebi

exbi : ElemUnit q -> ElemUnit q
exbi = twoToTheTen "exbi" 6
ei : ElemUnit q -> ElemUnit q
ei = exbi

zebi : ElemUnit q -> ElemUnit q
zebi = twoToTheTen "zebi" 7
zi : ElemUnit q -> ElemUnit q
zi = zebi

yobi : ElemUnit q -> ElemUnit q
yobi = twoToTheTen "yobi" 8
yi : ElemUnit q -> ElemUnit q
yi = yobi

-- Please Note: kibi byte /= kilo byte
