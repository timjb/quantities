module Quantities.NonSIUnits

import Quantities.Core
import Quantities.SIBaseQuantities
import Quantities.SIDerivedQuantities
import Quantities.SIPrefixes
import Quantities.SIBaseUnits
import Quantities.SIDerivedUnits

%default total
%access public


-- Based on http://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI

Minute : ElemUnit Time
Minute = < one "min" equals 60 Second >
Min : ElemUnit Time
Min = Minute

Hour : ElemUnit Time
Hour = < one "h" equals 60 Minute >
H : ElemUnit Time
H = Hour

Day : ElemUnit Time
Day = < one "d" equals 24 Hour >
D : ElemUnit Time
D = Day

Week : ElemUnit Time
Week = < one "week" equals 7 Day >

-- Julian year
Year : ElemUnit Time
Year = < one "a" equals 365.25 Day >
JulianYear : ElemUnit Time
JulianYear = Year
A : ElemUnit Time
A = Year

Century : Unit Time
Century = hecto Year

Millenium : Unit Time
Millenium = kilo Year

Tonne : ElemUnit Mass
Tonne = < one "t" equals 1000 Kg >
T : ElemUnit Mass
T = Tonne

Degree : ElemUnit PlaneAngle
Degree = < one "deg" equals (pi / 180) Rad >
Deg : ElemUnit PlaneAngle
Deg = Degree

Arcmin : ElemUnit PlaneAngle
Arcmin = < one "arcmin" equals (1/60) Degree >

Arcsec : ElemUnit PlaneAngle
Arcsec = < one "arcsec" equals (1/60) Arcmin >

-- Ångström (Å)
Angstrom : ElemUnit Length
Angstrom = < one "angstrom" equals 0.1 (nano Metre) >

AstronomicalUnit : ElemUnit Length
AstronomicalUnit = < one "au" equals 149597870700 Metre >
Au : ElemUnit Length
Au = AstronomicalUnit

StandardGravity : ElemUnit Acceleration
StandardGravity = < one "g_0" equals 9.80665 (Metre <//> (Second ^^ 2)) >
G_0 : ElemUnit Acceleration
G_0 = StandardGravity

RotationsPerMinute : Unit Frequency
RotationsPerMinute = One <//> Minute
Rpm : Unit Frequency
Rpm = RotationsPerMinute

-- Use this only for relative temparature! Not suitable for conversions of
-- absolute temperature!

Fahrenheit : ElemUnit Temperature
Fahrenheit = < one "dF" equals (5/9) K > -- °F
DF : ElemUnit Temperature
DF = Fahrenheit

Are : ElemUnit Area
Are = < one "are" equals 100 (Metre ^^ 2) >

Hectare : ElemUnit Area
Hectare = < one "ha" equals 1 ((hecto Metre) ^^ 2) >
Ha : ElemUnit Area
Ha = Hectare

Barn : ElemUnit Area
Barn = < one "b" equals 100 ((femto Metre) ^^ 2) >
B : ElemUnit Area
B = Barn

Litre : ElemUnit Volume
Litre = < one "l" equals 1 (milli (Metre ^^ 3)) >
Liter : ElemUnit Volume
Liter = Litre
L : ElemUnit Volume
L = Litre

Bar : ElemUnit Pressure
Bar = < one "bar" equals 100 (kilo Pascal) >

MillimetreOfMercury : ElemUnit Pressure
MillimetreOfMercury = < one "mmHg" equals 133.322 Pascal >
MmHg : ElemUnit Pressure
MmHg = MillimetreOfMercury

Calorie : ElemUnit Energy
Calorie = < one "cal" equals 4.18400 Joule >
ThermochemicalCalorie : ElemUnit Energy
ThermochemicalCalorie = Calorie
Cal : ElemUnit Energy
Cal = Calorie


-- Non-SI units whose values in SI must be determined experimentally

Electronvolt : ElemUnit Energy
Electronvolt = < one "eV" equals 1.60217653 (Ten ^^ -19 <**> Joule) >
EV : ElemUnit Energy
EV = Electronvolt

Dalton : ElemUnit Mass
Dalton = < one "Da" equals 1.66053886 (Ten ^^ -27 <**> Kilogram) >
Da : ElemUnit Mass
Da = Dalton
UnifiedAtomicMassUnit : ElemUnit Mass
UnifiedAtomicMassUnit = Dalton
U : ElemUnit Mass
U = Dalton

-- Atomic and natural units

ElementaryCharge : ElemUnit ElectricCharge
ElementaryCharge = < one "e" equals 1.60217653 (Ten ^^ -19 <**> Coulomb) >
E : ElemUnit ElectricCharge
E = ElementaryCharge

MassOfElectron : ElemUnit Mass
MassOfElectron = < one "m_e" equals 9.1093826 (Ten ^^ -31 <**> Kilogram) >
ElectronMass : ElemUnit Mass
ElectronMass = MassOfElectron
M_e : ElemUnit Mass
M_e = MassOfElectron

BohrRadius : ElemUnit Length
BohrRadius = < one "a_0" equals 0.5291772108 (Ten ^^ -10 <**> Metre) >
Bohr : ElemUnit Length
Bohr = BohrRadius
A_0 : ElemUnit Length
A_0 = BohrRadius

HartreeEnergy : ElemUnit Energy
HartreeEnergy = < one "E_h" equals 4.35974417 (Ten ^^ -18 <**> Joule) >
Hartree : ElemUnit Energy
Hartree = HartreeEnergy
E_h : ElemUnit Energy
E_h = HartreeEnergy

PlanckConstant : ElemUnit (Energy <*> Time)
PlanckConstant = < one "h" equals 6.62606957 (Joule <**> Second) >
H_ : ElemUnit (Energy <*> Time)
H_ = PlanckConstant

ReducedPlanckConstant : ElemUnit (Energy <*> Time)
ReducedPlanckConstant = < one "hBar" equals (1 / (2*pi)) (Joule <**> Second) >
HBar : ElemUnit (Energy <*> Time)
HBar = ReducedPlanckConstant

AtomicUnitOfTime : ElemUnit Time
AtomicUnitOfTime = < one "auOfTime" equals 1 (HBar <//> Hartree) >
AuOfTime : ElemUnit Time
AuOfTime = AtomicUnitOfTime

SpeedOfLight : ElemUnit Speed
SpeedOfLight = < one "c_0" equals 299792458 (Metre <//> Second) >
C_0 : ElemUnit Speed
C_0 = SpeedOfLight

NaturalUnitOfTime : ElemUnit Time
NaturalUnitOfTime = < one "nuOfTime" equals 1 (HBar <//> (M_e <**> (C_0 ^^ 2))) >
NuOfTime : ElemUnit Time
NuOfTime = NaturalUnitOfTime

LightSecond : ElemUnit Length
LightSecond = < one "ls" equals 1 (Second <**> SpeedOfLight) >
Ls : ElemUnit Length
Ls = LightSecond

LightMinute : ElemUnit Length
LightMinute = < one "lmin" equals 1 (Minute <**> SpeedOfLight) >
Lmin : ElemUnit Length
Lmin = LightMinute

LightHour : ElemUnit Length
LightHour = < one "lh" equals 1 (Hour <**> SpeedOfLight) >
Lh : ElemUnit Length
Lh = LightHour

LightDay : ElemUnit Length
LightDay = < one "ld" equals 1 (Day <**> SpeedOfLight) >
Ld : ElemUnit Length
Ld = LightDay

LightWeek : ElemUnit Length
LightWeek = < one "ld" equals 1 (Week <**> SpeedOfLight) >
Lw : ElemUnit Length
Lw = LightWeek

LightYear : ElemUnit Length
LightYear = < one "ly" equals 1 (Year <**> SpeedOfLight) >
Ly : ElemUnit Length
Ly = LightYear


-- Non-SI units associated with the CGS and the CGS-Gaussian system of units

Erg : Unit Energy
Erg = Ten ^^ -7 <**> Joule

Dyne : Unit Force'
Dyne = Ten ^^ -5 <**> Newton
Dyn : Unit Force'
Dyn = Dyne

Poise : Unit DynamicViscosity
Poise = Dyne <**> Second <//> (Centimetre ^^ 2)
P : Unit DynamicViscosity
P = Poise

Stokes : Unit KinematicViscosity
Stokes = Centimetre ^^ 2 <//> Second
St : Unit KinematicViscosity
St = Stokes

Stilb : Unit Luminance
Stilb = Candela <//> (Centimetre ^^ 2)
Sb : Unit Luminance
Sb = Stilb

Phot : Unit Illuminance
Phot = Candela <**> Steradian <//> (Centimetre ^^ 2)
Ph : Unit Illuminance
Ph = Phot

Gal : Unit Acceleration
Gal = Centimetre <//> (Second ^^ 2)

Maxwell : Unit MagneticFlux
Maxwell = Ten ^^ -8 <**> Weber
Mx : Unit MagneticFlux
Mx = Maxwell

Gauss : Unit MagneticFluxDensity
Gauss = Maxwell <//> (Centimetre ^^ 2)
G : Unit MagneticFluxDensity
G = Gauss

Oersted : ElemUnit MagneticFieldStrength
Oersted = < one "oe" equals (250 / pi) (Ampere <//> Metre) >
Oe : ElemUnit MagneticFieldStrength
Oe = Oersted
