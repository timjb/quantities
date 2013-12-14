module Quantities.Units

import Quantities
import Quantities.Quantities

%default total

meter : ElemUnit length
meter = MkElemUnit "m" 1

-- TODO: use general 'kilo', 'milli', etc. combinators
kilometer : ElemUnit length
kilometer = MkElemUnit "km" 1000

second : ElemUnit time
second = MkElemUnit "s" 1

minute : ElemUnit time
minute = one "min" is 60 second

hour : ElemUnit time
hour = one "h" is 60 minute

day : ElemUnit time
day = one "d" is 24 hour


kmh : Unit speed
kmh = ConsUnit kilometer 1 (ConsUnit hour (-1) EmptyUnit)

ms : Unit speed
ms = ConsUnit meter 1 (ConsUnit second (-1) EmptyUnit)

-- Use only for relative temparature! Not suitable for conversions of absolute
-- temperature!
kelvin : ElemUnit temperature
kelvin = MkElemUnit "°K" 1

celsius : ElemUnit temperature
celsius = MkElemUnit "°C" 1

fahrenheit : ElemUnit temperature
fahrenheit = MkElemUnit "°F" (5/9)
