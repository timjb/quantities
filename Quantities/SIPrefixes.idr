module Quantities.SIPrefixes

import Quantities.Core

%default total
%access public export

makePrefix : Integer -> Unit q -> Unit q
makePrefix i (MkUnit e us) = MkUnit (e+i) us


-- List of prefixes from
-- http://en.wikipedia.org/wiki/Metric_prefix

yotta : Unit q -> Unit q
yotta = makePrefix 24

zetta : Unit q -> Unit q
zetta = makePrefix 21

exa : Unit q -> Unit q
exa = makePrefix 18

peta : Unit q -> Unit q
peta = makePrefix 15

tera : Unit q -> Unit q
tera = makePrefix 12

giga : Unit q -> Unit q
giga = makePrefix 9
G : Unit q -> Unit q
G = giga

mega : Unit q -> Unit q
mega = makePrefix 6
M : Unit q -> Unit q
M = mega

kilo : Unit q -> Unit q
kilo = makePrefix 3
k : Unit q -> Unit q
k = kilo

hecto : Unit q -> Unit q
hecto = makePrefix 2

deca : Unit q -> Unit q
deca = makePrefix 1
da : Unit q -> Unit q
da = deca

-- ################## --

deci : Unit q -> Unit q
deci = makePrefix (-1)

centi : Unit q -> Unit q
centi = makePrefix (-2)

milli : Unit q -> Unit q
milli = makePrefix (-3)

micro : Unit q -> Unit q
micro = makePrefix (-6)

nano : Unit q -> Unit q
nano = makePrefix (-9)

pico : Unit q -> Unit q
pico = makePrefix (-12)

femto : Unit q -> Unit q
femto = makePrefix (-15)

atto : Unit q -> Unit q
atto = makePrefix (-18)

zepto : Unit q -> Unit q
zepto = makePrefix (-21)

yocto : Unit q -> Unit q
yocto = makePrefix (-24)
