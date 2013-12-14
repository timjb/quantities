module Quantities.Quantities

import Quantities

%default total

-- Elementary quantities

length : ElemQuantity
length = MkElemQuantity "Length"

mass : ElemQuantity
mass = MkElemQuantity "Mass"

time : ElemQuantity
time = MkElemQuantity "Time"

temperature : ElemQuantity
temperature = MkElemQuantity "Temperature"


-- Composed quantities

area : Quantity
area = length ^ 2

volume : Quantity
volume = length ^ 3

concentration : Quantity
concentration = length ^ (-3)

frequency : Quantity
frequency = time ^ (-1)

speed : Quantity
speed = length </> time

velocity : Quantity
velocity = speed

acceleration : Quantity
acceleration = speed </> time

force : Quantity
force = acceleration <*> mass

energy : Quantity
energy = force <*> length

power : Quantity
power = energy </> time
