module Quantities.Quantities

import Quantities

%default total

area : Quantity
area = length ^ 2

volume : Quantity
volume = length ^ 3

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
