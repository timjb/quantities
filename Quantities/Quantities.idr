module Quantities.Quantities

import Quantities.FreeAbelianGroup
import Quantities

%default total
%access public


-- Elementary quantities

Length : ElemQuantity
Length = MkElemQuantity "Length"

Mass : ElemQuantity
Mass = MkElemQuantity "Mass"

Time : ElemQuantity
Time = MkElemQuantity "Time"

Temperature : ElemQuantity
Temperature = MkElemQuantity "Temperature"


-- Composed quantities

Area : Quantity
Area = Length ^ 2

Volume : Quantity
Volume = Length ^ 3

Concentration : Quantity
Concentration = Length ^ (-3)

Frequency : Quantity
Frequency = Time ^ (-1)

Speed : Quantity
Speed = Length </> Time

Velocity : Quantity
Velocity = Speed

Acceleration : Quantity
Acceleration = Speed </> Time

Force : Quantity
Force = Acceleration <*> Mass

Energy : Quantity
Energy = Force <*> Length

Power : Quantity
Power = Energy </> Time

Pressure : Quantity
Pressure = Force </> Area
