module Quantities.NonSIUnits

import Quantities
import Quantities.SIPrefixes
import Quantities.SIBaseUnits
import Quantities.SIDerivedUnits

%default total
%access public


-- Based on http://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI

minute : ElemUnit Time
minute = < one "min" equals 60 second >
min : ElemUnit Time
min = minute

hour : ElemUnit Time
hour = < one "h" equals 60 minute >
h : ElemUnit Time
h = hour

day : ElemUnit Time
day = < one "d" equals 24 hour >
d : ElemUnit Time
d = day

week : ElemUnit Time
week = < one "week" equals 7 day >

-- Julian year
year : ElemUnit Time
year = < one "a" equals 365.25 day >
julianYear : ElemUnit Time
julianYear = year
a : ElemUnit Time
a = year

tonne : ElemUnit Mass
tonne = < one "t" equals 1000 kg >
t : ElemUnit Mass
t = tonne

degree : ElemUnit PlaneAngle
degree = < one "deg" equals (pi / 180) rad >
deg : ElemUnit PlaneAngle
deg = degree

arcmin : ElemUnit PlaneAngle
arcmin = < one "arcmin" equals (1/60) degree >

arcsec : ElemUnit PlaneAngle
arcsec = < one "arcsec" equals (1/60) arcmin >

-- Ångström (Å)
angstrom : ElemUnit Length
angstrom = < one "angstrom" equals 0.1 (nano metre) >

astronomicalUnit : ElemUnit Length
astronomicalUnit = < one "au" equals 149597870700 metre >
au : ElemUnit Length
au = astronomicalUnit

standardGravity : ElemUnit Acceleration
standardGravity = < one "g_0" equals 9.80665 (metre <//> (second ^^ 2)) >
g_0 : ElemUnit Acceleration
g_0 = standardGravity

rotationsPerMinute : Unit Frequency
rotationsPerMinute = one <//> minute
rpm : Unit Frequency
rpm = rotationsPerMinute

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

fahrenheit : ElemUnit Temperature
fahrenheit = < one "dF" equals (5/9) K > -- °F
dF : ElemUnit Temperature
dF = fahrenheit

are : ElemUnit Area
are = < one "are" equals 100 (metre ^^ 2) >

hectare : ElemUnit Area
hectare = < one "ha" equals 1 ((hecto metre) ^^ 2) >
ha : ElemUnit Area
ha = hectare

barn : ElemUnit Area
barn = < one "b" equals 100 ((femto metre) ^^ 2) >
b : ElemUnit Area
b = barn

litre : ElemUnit Volume
litre = < one "l" equals 1 (milli (m ^^ 3)) >
liter : ElemUnit Volume
liter = litre
l : ElemUnit Volume
l = litre

bar : ElemUnit Pressure
bar = < one "bar" equals 100 (kilo pascal) >

millimetreOfMercury : ElemUnit Pressure
millimetreOfMercury = < one "mmHg" equals 133.322 pascal >
mmHg : ElemUnit Pressure
mmHg = millimetreOfMercury


-- Non-SI units whose values in SI must be determined experimentally

electronvolt : ElemUnit Energy
electronvolt = < one "eV" equals 1.60217653 (ten ^^ -19 <**> joule) >
eV : ElemUnit Energy
eV = electronvolt

dalton : ElemUnit Mass
dalton = < one "Da" equals 1.66053886 (ten ^^ -27 <**> kilogram) >
Da : ElemUnit Mass
Da = dalton
unifiedAtomicMassUnit : ElemUnit Mass
unifiedAtomicMassUnit = dalton
u : ElemUnit Mass
u = dalton

-- Atomic and natural units

elementaryCharge : ElemUnit ElectricCharge
elementaryCharge = < one "e" equals 1.60217653 (ten ^^ -19 <**> coulomb) >
e : ElemUnit ElectricCharge
e = elementaryCharge

massOfElectron : ElemUnit Mass
massOfElectron = < one "m_e" equals 9.1093826 (ten ^^ -31 <**> kilogram) >
electronMass : ElemUnit Mass
electronMass = massOfElectron
m_e : ElemUnit Mass
m_e = massOfElectron

bohrRadius : ElemUnit Length
bohrRadius = < one "a_0" equals 0.5291772108 (ten ^^ -10 <**> metre) >
bohr : ElemUnit Length
bohr = bohrRadius
a_0 : ElemUnit Length
a_0 = bohrRadius

hartreeEnergy : ElemUnit Energy
hartreeEnergy = < one "E_h" equals 4.35974417 (ten ^^ -18 <**> joule) >
hartree : ElemUnit Energy
hartree = hartreeEnergy
E_h : ElemUnit Energy
E_h = hartreeEnergy

planckConstant : ElemUnit (Energy <*> Time)
planckConstant = < one "h" equals 6.62606957 (joule <**> second) >
h_ : ElemUnit (Energy <*> Time)
h_ = planckConstant

reducedPlanckConstant : ElemUnit (Energy <*> Time)
reducedPlanckConstant = < one "hBar" equals (1 / (2*pi)) (joule <**> second) >
hBar : ElemUnit (Energy <*> Time)
hBar = reducedPlanckConstant

atomicUnitOfTime : ElemUnit Time
atomicUnitOfTime = < one "auOfTime" equals 1 (hBar <//> hartree) >
auOfTime : ElemUnit Time
auOfTime = atomicUnitOfTime

speedOfLight : ElemUnit Speed
speedOfLight = < one "c_0" equals 299792458 (metre <//> second) >
c_0 : ElemUnit Speed
c_0 = speedOfLight

naturalUnitOfTime : ElemUnit Time
naturalUnitOfTime = < one "nuOfTime" equals 1 (hBar <//> (m_e <**> (c_0 ^^ 2))) >
nuOfTime : ElemUnit Time
nuOfTime = naturalUnitOfTime

lightSecond : ElemUnit Length
lightSecond = < one "ls" equals 1 (second <**> speedOfLight) >
ls : ElemUnit Length
ls = lightSecond

lightMinute : ElemUnit Length
lightMinute = < one "lmin" equals 1 (minute <**> speedOfLight) >
lmin : ElemUnit Length
lmin = lightMinute

lightHour : ElemUnit Length
lightHour = < one "lh" equals 1 (hour <**> speedOfLight) >
lh : ElemUnit Length
lh = lightHour

lightDay : ElemUnit Length
lightDay = < one "ld" equals 1 (day <**> speedOfLight) >
ld : ElemUnit Length
ld = lightDay

lightWeek : ElemUnit Length
lightWeek = < one "ld" equals 1 (week <**> speedOfLight) >
lw : ElemUnit Length
lw = lightWeek

lightYear : ElemUnit Length
lightYear = < one "ly" equals 1 (year <**> speedOfLight) >
ly : ElemUnit Length
ly = lightYear


-- Non-SI units associated with the CGS and the CGS-Gaussian system of units

erg : Unit Energy
erg = ten ^^ -7 <**> joule

dyne : Unit Force
dyne = ten ^^ -5 <**> newton
dyn : Unit Force
dyn = dyne

poise : Unit DynamicViscosity
poise = dyne <**> second <//> (centimetre ^^ 2)
P : Unit DynamicViscosity
P = poise

stokes : Unit KinematicViscosity
stokes = centimetre ^^ 2 <//> second
St : Unit KinematicViscosity
St = stokes

stilb : Unit Luminance
stilb = candela <//> (centimetre ^^ 2)
sb : Unit Luminance
sb = stilb

phot : Unit Illuminance
phot = candela <**> steradian <//> (centimetre ^^ 2)
ph : Unit Illuminance
ph = phot

gal : Unit Acceleration
gal = centimetre <//> (second ^^ 2)
Gal : Unit Acceleration
Gal = gal

maxwell : Unit MagneticFlux
maxwell = ten ^^ -8 <**> weber
Mx : Unit MagneticFlux
Mx = maxwell

gauss : Unit MagneticFluxDensity
gauss = maxwell <//> (centimetre ^^ 2)
G : Unit MagneticFluxDensity
G = gauss

oersted : ElemUnit MagneticFieldStrength
oersted = < one "oe" equals (250 / pi) (ampere <//> metre) >
oe : ElemUnit MagneticFieldStrength
oe = oersted
