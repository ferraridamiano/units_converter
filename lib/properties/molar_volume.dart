// ignore_for_file: camel_case_types

import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

enum MOLAR_VOLUME {
  molesPerLiter(AMOUNT_OF_SUBSTANCE.moles, VOLUME.liters),
  molesPerMilliliter(AMOUNT_OF_SUBSTANCE.moles, VOLUME.milliliters),
  molesPerCubicMeter(AMOUNT_OF_SUBSTANCE.moles, VOLUME.cubicMeters),
  millimolesPerLiter(AMOUNT_OF_SUBSTANCE.millimoles, VOLUME.liters),
  millimolesPerDeciliter(AMOUNT_OF_SUBSTANCE.millimoles, VOLUME.deciliters),
  micromolesPerLiter(AMOUNT_OF_SUBSTANCE.micromoles, VOLUME.liters),
  micromolesPerDeciliter(AMOUNT_OF_SUBSTANCE.micromoles, VOLUME.deciliters),
  micromolesPerMilliliter(AMOUNT_OF_SUBSTANCE.micromoles, VOLUME.milliliters),
  nanomolesPerLiter(AMOUNT_OF_SUBSTANCE.nanomoles, VOLUME.liters),
  nanomolesPerDeciliter(AMOUNT_OF_SUBSTANCE.nanomoles, VOLUME.deciliters),
  nanomolesPerMilliliter(AMOUNT_OF_SUBSTANCE.nanomoles, VOLUME.milliliters),
  picomolesPerLiter(AMOUNT_OF_SUBSTANCE.picomoles, VOLUME.liters),
  picomolesPerDeciliter(AMOUNT_OF_SUBSTANCE.picomoles, VOLUME.deciliters),
  picomolesPerMilliliter(AMOUNT_OF_SUBSTANCE.picomoles, VOLUME.milliliters),
  femtomolesPerMilliliter(AMOUNT_OF_SUBSTANCE.femtomoles, VOLUME.milliliters),
  ;

  final AMOUNT_OF_SUBSTANCE numerator;
  final VOLUME denominator;
  const MOLAR_VOLUME(this.numerator, this.denominator);
}

class MolarVolume
    extends RatioProperty<MOLAR_VOLUME, AMOUNT_OF_SUBSTANCE, MASS> {
  // NOTE: All values of MOLAR_VOLUME must be reported in this variable
  static const Map<MOLAR_VOLUME, String?> _mapSymbols = {
    MOLAR_VOLUME.molesPerLiter: 'mol/l',
    MOLAR_VOLUME.molesPerMilliliter: 'mol/ml',
    MOLAR_VOLUME.molesPerCubicMeter: 'mol/m³',
    MOLAR_VOLUME.millimolesPerLiter: 'mmol/l',
    MOLAR_VOLUME.millimolesPerDeciliter: 'mmol/dl',
    MOLAR_VOLUME.micromolesPerLiter: 'µmol/l',
    MOLAR_VOLUME.micromolesPerDeciliter: 'µmol/dl',
    MOLAR_VOLUME.micromolesPerMilliliter: 'µmol/ml',
    MOLAR_VOLUME.nanomolesPerLiter: 'nmol/l',
    MOLAR_VOLUME.nanomolesPerDeciliter: 'nmol/dl',
    MOLAR_VOLUME.nanomolesPerMilliliter: 'nl/ml',
    MOLAR_VOLUME.picomolesPerLiter: 'pmol/l',
    MOLAR_VOLUME.picomolesPerDeciliter: 'pmol/dl',
    MOLAR_VOLUME.picomolesPerMilliliter: 'pmol/ml',
    MOLAR_VOLUME.femtomolesPerMilliliter: 'fmol/ml',
  };

  ///Class for molar volume conversions, e.g. if you want to convert 1 mole per liter
  ///in moles per milliliter:
  ///```dart
  ///var molarVolume = MolarVolume(removeTrailingZeros: false);
  ///molarVolume.convert(Unit(MOLAR_VOLUME.molesPerLiter, value: 1));
  ///print(MOLAR_VOLUME.molesPerMilliliter);
  /// ```
  MolarVolume(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : assert(_mapSymbols.length == MOLAR_VOLUME.values.length),
        super(
            name: name ?? PROPERTY.molarvolume,
            numeratorProperty:
                getPropertyFromEnum(MOLAR_VOLUME.values[0].numerator)!,
            denominatorProperty:
                getPropertyFromEnum(MOLAR_VOLUME.values[0].denominator)!,
            mapSymbols: _mapSymbols);

  Unit get molesPerLiter => getUnit(MOLAR_VOLUME.molesPerLiter);
  Unit get molesPerMilliliter => getUnit(MOLAR_VOLUME.molesPerMilliliter);
  Unit get molesPerCubicMeter => getUnit(MOLAR_VOLUME.molesPerCubicMeter);
  Unit get millimolesPerLiter => getUnit(MOLAR_VOLUME.millimolesPerLiter);
  Unit get millimolesPerDeciliter =>
      getUnit(MOLAR_VOLUME.millimolesPerDeciliter);
  Unit get micromolesPerLiter => getUnit(MOLAR_VOLUME.micromolesPerLiter);
  Unit get micromolesPerDeciliter =>
      getUnit(MOLAR_VOLUME.micromolesPerDeciliter);
  Unit get micromolesPerMilliliter =>
      getUnit(MOLAR_VOLUME.micromolesPerMilliliter);
  Unit get nanomolesPerLiter => getUnit(MOLAR_VOLUME.nanomolesPerLiter);
  Unit get nanomolesPerDeciliter => getUnit(MOLAR_VOLUME.nanomolesPerDeciliter);
  Unit get nanomolesPerMilliliter =>
      getUnit(MOLAR_VOLUME.nanomolesPerMilliliter);
  Unit get picomolesPerLiter => getUnit(MOLAR_VOLUME.picomolesPerLiter);
  Unit get picomolesPerDeciliter => getUnit(MOLAR_VOLUME.picomolesPerDeciliter);
  Unit get picomolesPerMilliliter =>
      getUnit(MOLAR_VOLUME.picomolesPerMilliliter);
  Unit get femtomolesPerMilliliter =>
      getUnit(MOLAR_VOLUME.femtomolesPerMilliliter);
}
