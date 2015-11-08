# 2015-11-08

Capitalized all units. This change is necessary since Idris interprets the `watt` in `F watt` as an implicit type argument in version 0.9.20, since it begins with a lower-case letter. The alternative would have been to require the user to use qualified names: `F Quantities.SIDerivedUnits.watt`