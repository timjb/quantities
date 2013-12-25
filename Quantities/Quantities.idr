module Quantities.Quantities

import Quantities.FreeAbelianGroup
import Quantities

%default total
%access public


-- Elementary quantities

Length : Dimension
Length = MkDimension "Length"

Mass : Dimension
Mass = MkDimension "Mass"

Time : Dimension
Time = MkDimension "Time"

Temperature : Dimension
Temperature = MkDimension "Temperature"


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
