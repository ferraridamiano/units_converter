import 'package:units_converter/units_converter.dart';

enum Ratio {
  nanoMolesPerMole,
  microMolesPerMole,
  milliMolesPerMole,
  microGramsPerNanoGram,
  nanoGramsPerMilliGram,
  microGramsPerMilliGram,
  milliGramsPerMilliGram,
  nanoGramsPerGram,
  microGramsPerGram,
  milliGramsPerGram,
  gramsPerGram,
  nanoGramsPerKiloGram,
  microGramsPerKiloGram,
  milliGramsPerKiloGram,
  gramsPerKiloGram,
  picoMolesPerMicroMole,
  nanoMolesPerMilliMole,
  milliLitersPerDeciLiter,
  picoGramsPerMilliMeter,
  milliMolesPerSquareMeter,
  femtoMolesPerMilliGram,
  nanoMolesPerMilliGram,
  microMolesPerMilliGram,
  molesPerKiloGram,
  femtoMolesPerGram,
  nanoMolesPerGram,
  microMolesPerGram,
  milliMolesPerGram,
  milliMolesPerKiloGram,
  milliLitersPerKiloGram,
  litersPerKilogram,
  kiloCaloriesPerOunce,
  gramsPerSquareMeter,
  kiloGramsPerSquareMeter,
  microGramsPerSquareMeter,
  milliGramsPerSquareMeter,
  nanoGramsPerSquareMeter,
  milliGramsPerDeciLiter,
  gramsPerDeciLiter,
  nanoGramsPerLiter,
  picoGramsPerLiter,
  microGramsPerLiter,
  milliGramsPerLiter,
  milliGramsPerMilliliter,
  gramsPerLiter,
  kiloGramsPerLiter,
  milliGramsPerCubicMeter,
  kiloGramsPerCubicMeter,
  femtoMolesPerMilliLiter,
  picoMolesPerMilliLiter,
  nanoMolesPerMilliLiter,
  microMolesPerMilliLiter,
  molesPerMilliLiter,
  picoMolesPerDeciLiter,
  nanoMolesPerDeciLiter,
  microMolesPerDeciLiter,
  milliMolesPerDeciLiter,
  milliMolesPerLiter,
  picoMolesPerLiter,
  nanoMolesPerLiter,
  microMolesPerLiter,
  molesPerLiter,
  molesPerCubicMeter,
  gramsPerMilliLiter,
  nanoGramsPerMilliLiter,
  picoGramsPerMilliLiter,
  microGramsPerDeciLiter,
  microGramsPerMilliLiter,
}

extension UnitsFromRatio on Ratio {
  dynamic numeratorUnit() {
    switch (this) {
      case Ratio.nanoMolesPerMole:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.microMolesPerMole:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.milliMolesPerMole:
        return AMOUNTOFSUBSTANCE.millimoles;

      case Ratio.microGramsPerNanoGram:
        return MASS.micrograms;

      case Ratio.nanoGramsPerMilliGram:
        return MASS.nanograms;

      case Ratio.microGramsPerMilliGram:
        return MASS.micrograms;

      case Ratio.milliGramsPerMilliGram:
        return MASS.milligrams;

      case Ratio.nanoGramsPerGram:
        return MASS.nanograms;

      case Ratio.microGramsPerGram:
        return MASS.micrograms;

      case Ratio.milliGramsPerGram:
        return MASS.milligrams;

      case Ratio.gramsPerGram:
        return MASS.grams;

      case Ratio.nanoGramsPerKiloGram:
        return MASS.nanograms;

      case Ratio.microGramsPerKiloGram:
        return MASS.micrograms;

      case Ratio.milliGramsPerKiloGram:
        return MASS.milligrams;

      case Ratio.gramsPerKiloGram:
        return MASS.grams;

      case Ratio.picoMolesPerMicroMole:
        return AMOUNTOFSUBSTANCE.picomoles;

      case Ratio.nanoMolesPerMilliMole:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.milliLitersPerDeciLiter:
        return VOLUME.milliliters;

      case Ratio.picoGramsPerMilliMeter:
        return MASS.picograms;

      case Ratio.milliMolesPerSquareMeter:

      case Ratio.femtoMolesPerMilliGram:
        return AMOUNTOFSUBSTANCE.femtomoles;

      case Ratio.nanoMolesPerMilliGram:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.microMolesPerMilliGram:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.molesPerKiloGram:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.femtoMolesPerGram:
        return AMOUNTOFSUBSTANCE.femtomoles;

      case Ratio.nanoMolesPerGram:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.microMolesPerGram:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.milliMolesPerGram:
        return AMOUNTOFSUBSTANCE.millimoles;

      case Ratio.milliMolesPerKiloGram:
        return AMOUNTOFSUBSTANCE.millimoles;

      case Ratio.milliLitersPerKiloGram:
        return VOLUME.milliliters;

      case Ratio.litersPerKilogram:
        return VOLUME.liters;

      case Ratio.kiloCaloriesPerOunce:
        return ENERGY.kilocalories;

      case Ratio.gramsPerSquareMeter:
        return MASS.grams;

      case Ratio.kiloGramsPerSquareMeter:
        return MASS.kilograms;

      case Ratio.microGramsPerSquareMeter:
        return MASS.micrograms;

      case Ratio.milliGramsPerSquareMeter:
        return MASS.milligrams;

      case Ratio.nanoGramsPerSquareMeter:
        return MASS.nanograms;

      case Ratio.milliGramsPerDeciLiter:
        return MASS.milligrams;

      case Ratio.gramsPerDeciLiter:
        return MASS.grams;

      case Ratio.nanoGramsPerLiter:
        return MASS.nanograms;

      case Ratio.picoGramsPerLiter:
        return MASS.picograms;

      case Ratio.microGramsPerLiter:
        return MASS.micrograms;

      case Ratio.milliGramsPerLiter:
        return MASS.milligrams;

      case Ratio.gramsPerLiter:
        return MASS.grams;

      case Ratio.kiloGramsPerLiter:
        return MASS.kilograms;

      case Ratio.milliGramsPerCubicMeter:
        return MASS.milligrams;

      case Ratio.kiloGramsPerCubicMeter:
        return MASS.kilograms;

      case Ratio.femtoMolesPerMilliLiter:
        return AMOUNTOFSUBSTANCE.femtomoles;

      case Ratio.picoMolesPerMilliLiter:
        return AMOUNTOFSUBSTANCE.picomoles;

      case Ratio.nanoMolesPerMilliLiter:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.microMolesPerMilliLiter:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.molesPerMilliLiter:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.picoMolesPerDeciLiter:
        return AMOUNTOFSUBSTANCE.picomoles;

      case Ratio.nanoMolesPerDeciLiter:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.microMolesPerDeciLiter:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.milliMolesPerDeciLiter:
        return AMOUNTOFSUBSTANCE.millimoles;

      case Ratio.milliMolesPerLiter:
        return AMOUNTOFSUBSTANCE.millimoles;

      case Ratio.picoMolesPerLiter:
        return AMOUNTOFSUBSTANCE.picomoles;

      case Ratio.nanoMolesPerLiter:
        return AMOUNTOFSUBSTANCE.nanomoles;

      case Ratio.microMolesPerLiter:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.molesPerLiter:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.molesPerCubicMeter:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.gramsPerMilliLiter:
        return MASS.grams;

      case Ratio.nanoGramsPerMilliLiter:
        return MASS.nanograms;

      case Ratio.picoGramsPerMilliLiter:
        return MASS.picograms;

      case Ratio.microGramsPerDeciLiter:
        return MASS.micrograms;

      case Ratio.microGramsPerMilliLiter:
        return MASS.micrograms;

      case Ratio.milliGramsPerMilliliter:
        return MASS.milligrams;
    }
  }

  dynamic denominatorUnit() {
    switch (this) {
      case Ratio.nanoMolesPerMole:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.microMolesPerMole:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.milliMolesPerMole:
        return AMOUNTOFSUBSTANCE.moles;

      case Ratio.microGramsPerNanoGram:
        return MASS.grams;

      case Ratio.nanoGramsPerMilliGram:
        return MASS.milligrams;

      case Ratio.microGramsPerMilliGram:
        return MASS.milligrams;

      case Ratio.milliGramsPerMilliGram:
        return MASS.milligrams;

      case Ratio.nanoGramsPerGram:
        return MASS.grams;

      case Ratio.microGramsPerGram:
        return MASS.grams;

      case Ratio.milliGramsPerGram:
        return MASS.grams;

      case Ratio.gramsPerGram:
        return MASS.grams;

      case Ratio.nanoGramsPerKiloGram:
        return MASS.kilograms;

      case Ratio.microGramsPerKiloGram:
        return MASS.kilograms;

      case Ratio.milliGramsPerKiloGram:
        return MASS.kilograms;

      case Ratio.gramsPerKiloGram:
        return MASS.kilograms;

      case Ratio.picoMolesPerMicroMole:
        return AMOUNTOFSUBSTANCE.micromoles;

      case Ratio.nanoMolesPerMilliMole:
        return AMOUNTOFSUBSTANCE.millimoles;

      case Ratio.milliLitersPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.picoGramsPerMilliMeter:
        return LENGTH.millimeters;

      case Ratio.milliMolesPerSquareMeter:
        return AREA.squareMeters;

      case Ratio.femtoMolesPerMilliGram:
        return MASS.milligrams;

      case Ratio.nanoMolesPerMilliGram:
        return MASS.milligrams;

      case Ratio.microMolesPerMilliGram:
        return MASS.milligrams;

      case Ratio.molesPerKiloGram:
        return MASS.kilograms;

      case Ratio.femtoMolesPerGram:
        return MASS.grams;

      case Ratio.nanoMolesPerGram:
        return MASS.nanograms;

      case Ratio.microMolesPerGram:
        return MASS.grams;

      case Ratio.milliMolesPerGram:
        return MASS.grams;

      case Ratio.milliMolesPerKiloGram:
        return MASS.kilograms;

      case Ratio.milliLitersPerKiloGram:
        return MASS.kilograms;

      case Ratio.litersPerKilogram:
        return MASS.kilograms;

      case Ratio.kiloCaloriesPerOunce:
        return MASS.ounces;

      case Ratio.gramsPerSquareMeter:
        return AREA.squareMeters;

      case Ratio.kiloGramsPerSquareMeter:
        return AREA.squareMeters;

      case Ratio.microGramsPerSquareMeter:
        return AREA.squareMeters;

      case Ratio.milliGramsPerSquareMeter:
        return AREA.squareMeters;

      case Ratio.nanoGramsPerSquareMeter:
        return AREA.squareMeters;

      case Ratio.milliGramsPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.gramsPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.nanoGramsPerLiter:
        return VOLUME.liters;

      case Ratio.picoGramsPerLiter:
        return VOLUME.liters;

      case Ratio.microGramsPerLiter:
        return VOLUME.liters;

      case Ratio.milliGramsPerLiter:
        return VOLUME.liters;

      case Ratio.gramsPerLiter:
        return VOLUME.liters;

      case Ratio.kiloGramsPerLiter:
        return VOLUME.liters;

      case Ratio.milliGramsPerCubicMeter:
        return VOLUME.cubicMeters;

      case Ratio.kiloGramsPerCubicMeter:
        return VOLUME.cubicMeters;

      case Ratio.femtoMolesPerMilliLiter:
        return VOLUME.microliters;

      case Ratio.picoMolesPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.nanoMolesPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.microMolesPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.molesPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.picoMolesPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.nanoMolesPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.microMolesPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.milliMolesPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.milliMolesPerLiter:
        return VOLUME.liters;

      case Ratio.picoMolesPerLiter:
        return VOLUME.liters;

      case Ratio.nanoMolesPerLiter:
        return VOLUME.liters;

      case Ratio.microMolesPerLiter:
        return VOLUME.liters;

      case Ratio.molesPerLiter:
        return VOLUME.liters;

      case Ratio.molesPerCubicMeter:
        return VOLUME.cubicMeters;

      case Ratio.gramsPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.nanoGramsPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.picoGramsPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.microGramsPerDeciLiter:
        return VOLUME.deciliters;

      case Ratio.microGramsPerMilliLiter:
        return VOLUME.milliliters;

      case Ratio.milliGramsPerMilliliter:
        return VOLUME.milliliters;
    }
  }
}
