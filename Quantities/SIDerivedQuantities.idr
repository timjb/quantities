module Quantities.SIDerivedQuantities

import Quantities.Core
import Quantities.SIBaseQuantities

%default total
%access public export


-- Examples of coherent derived units in the SI expressed in terms of base
-- units

Area : Quantity
Area = Length ^ 2

Volume : Quantity
Volume = Length ^ 3

Speed : Quantity
Speed = Length </> Time

Velocity : Quantity
Velocity = Speed

Acceleration : Quantity
Acceleration = Speed </> Time

Wavenumber : Quantity
Wavenumber = Length ^ (-1)

Density : Quantity
Density = Mass </> Volume

MassDensity : Quantity
MassDensity = Density

SurfaceDensity : Quantity
SurfaceDensity = Mass </> Area

SpecificVolume : Quantity
SpecificVolume = Volume </> Mass

CurrentDensity : Quantity
CurrentDensity = ElectricCurrent </> Area

MagneticFieldStrength : Quantity
MagneticFieldStrength = ElectricCurrent </> Length

AmountConcentration : Quantity
AmountConcentration = AmountOfSubstance </> Volume

Concentration : Quantity
Concentration = AmountConcentration

MassConcentration : Quantity
MassConcentration = Mass </> Volume

Luminance : Quantity
Luminance = LuminousIntensity </> Area

RefractiveIndex : Quantity
RefractiveIndex = Scalar

RelativePermeability : Quantity
RelativePermeability = Scalar


-- Coherent derived units in the SI with special names and symbols

PlaneAngle : Quantity
PlaneAngle = Scalar

SolidAngle : Quantity
SolidAngle = Scalar

Frequency : Quantity
Frequency = Time ^ (-1)

Force' : Quantity
Force' = Acceleration <*> Mass

Pressure : Quantity
Pressure = Force' </> Area

Stress : Quantity
Stress = Pressure

Energy : Quantity
Energy = Force' <*> Length

Work : Quantity
Work = Energy

AmountOfHeat : Quantity
AmountOfHeat = Energy

Power : Quantity
Power = Energy </> Time

RadiantFlux : Quantity
RadiantFlux = Power

ElectricCharge : Quantity
ElectricCharge = Time <*> ElectricCurrent

AmountOfElectricity : Quantity
AmountOfElectricity = ElectricCharge

ElectricPotentialDifference : Quantity
ElectricPotentialDifference = Power </> ElectricCurrent

ElectromotiveForce : Quantity
ElectromotiveForce = ElectricPotentialDifference

Capacitance : Quantity
Capacitance = ElectricCharge </> ElectricPotentialDifference

ElectricResistance : Quantity
ElectricResistance = ElectricPotentialDifference </> ElectricCurrent

ElectricConductance : Quantity
ElectricConductance = ElectricCurrent </> ElectricPotentialDifference

MagneticFlux : Quantity
MagneticFlux = Time <*> ElectricPotentialDifference

MagneticFluxDensity : Quantity
MagneticFluxDensity = MagneticFlux </> Area

Inductance : Quantity
Inductance = MagneticFlux </> ElectricCurrent

-- Celsius temperature

LuminousFlux : Quantity
LuminousFlux = LuminousIntensity <*> SolidAngle

Illuminance : Quantity
Illuminance = LuminousFlux </> Area

ActivityReferredToARadionuclide : Quantity
ActivityReferredToARadionuclide = Time ^ (-1)

-- ... sometimes incorrectly called
Radioactivity : Quantity
Radioactivity = ActivityReferredToARadionuclide

AbsorbedDose : Quantity
AbsorbedDose = Energy </> Mass

SpecificEnergy : Quantity
SpecificEnergy = AbsorbedDose

Kerma : Quantity
Kerma = AbsorbedDose

DoseEquivalent : Quantity
DoseEquivalent = Energy </> Mass

AmbientDoseEquivalent : Quantity
AmbientDoseEquivalent = DoseEquivalent

DirectionalDoseEquivalent : Quantity
DirectionalDoseEquivalent = DoseEquivalent

PersonalDoseEquivalent : Quantity
PersonalDoseEquivalent = DoseEquivalent

CatalyticActivity : Quantity
CatalyticActivity = AmountOfSubstance </> Time


-- Examples of SI coherent derived units whose names and symbols include SI
-- coherent derived units with special names and symbols

DynamicViscosity : Quantity
DynamicViscosity = Stress <*> Time

KinematicViscosity : Quantity
KinematicViscosity = Area </> Time

MomentOfForce : Quantity
MomentOfForce = Force' <*> Length

Moment : Quantity
Moment = MomentOfForce

Torque : Quantity
Torque = MomentOfForce

SurfaceTension : Quantity
SurfaceTension = Force' </> Length

AngularVelocity : Quantity
AngularVelocity = PlaneAngle </> Time

AngularAcceleration : Quantity
AngularAcceleration = AngularVelocity </> Time

HeatFluxDensity : Quantity
HeatFluxDensity = Power </> Area

Irradiance : Quantity
Irradiance = HeatFluxDensity

HeatCapacity : Quantity
HeatCapacity = Energy </> Temperature

Entropy : Quantity
Entropy = HeatCapacity

SpecificHeatCapacity : Quantity
SpecificHeatCapacity = HeatCapacity </> Mass

SpecificEntropy : Quantity
SpecificEntropy = Entropy </> Mass

ThermalConductivity : Quantity
ThermalConductivity = Power </> (Length <*> Temperature)

EnergyDensity : Quantity
EnergyDensity = Energy </> Volume

ElectricFieldStrength : Quantity
ElectricFieldStrength = ElectricPotentialDifference </> Length

ElectricChargeDensity : Quantity
ElectricChargeDensity = ElectricCharge </> Volume

SurfaceChargeDensity : Quantity
SurfaceChargeDensity = ElectricCharge </> Area

ElectricFluxDensity : Quantity
ElectricFluxDensity = SurfaceChargeDensity

ElectricDisplacement : Quantity
ElectricDisplacement = SurfaceChargeDensity

Permettivity : Quantity
Permettivity = Capacitance </> Length

Permeability : Quantity
Permeability = Inductance </> Length

MolarEnergy : Quantity
MolarEnergy = Energy </> AmountOfSubstance

MolarHeatCapacity : Quantity
MolarHeatCapacity = MolarEnergy

Exposure : Quantity
Exposure = ElectricCharge </> Mass

AbsorbedDoseRate : Quantity
AbsorbedDoseRate = AbsorbedDose </> Time

RadiantIntensity : Quantity
RadiantIntensity = Power </> SolidAngle

Radiance : Quantity
Radiance = RadiantIntensity </> Area

CatalyticActivityConcentration : Quantity
CatalyticActivityConcentration = CatalyticActivity </> Volume
