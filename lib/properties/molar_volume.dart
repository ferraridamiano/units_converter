// ignore_for_file: camel_case_types

import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

enum MOLAR_VOLUME {
  molesPerLiter(AMOUNT_OF_SUBSTANCE.moles, VOLUME.liters),
  molesPerMilliLiter(AMOUNT_OF_SUBSTANCE.moles, VOLUME.milliliters),
  molesPerCubicMeter(AMOUNT_OF_SUBSTANCE.moles, VOLUME.cubicMeters),
  milliMolesPerLiter(AMOUNT_OF_SUBSTANCE.millimoles, VOLUME.liters),
  milliMolesPerDeciLiter(AMOUNT_OF_SUBSTANCE.millimoles, VOLUME.deciliters),
  microMolesPerLiter(AMOUNT_OF_SUBSTANCE.micromoles, VOLUME.liters),
  microMolesPerDeciLiter(AMOUNT_OF_SUBSTANCE.micromoles, VOLUME.deciliters),
  microMolesPerMilliLiter(AMOUNT_OF_SUBSTANCE.micromoles, VOLUME.milliliters),
  nanoMolesPerLiter(AMOUNT_OF_SUBSTANCE.nanomoles, VOLUME.liters),
  nanoMolesPerDeciLiter(AMOUNT_OF_SUBSTANCE.nanomoles, VOLUME.deciliters),
  nanoMolesPerMilliLiter(AMOUNT_OF_SUBSTANCE.nanomoles, VOLUME.milliliters),
  picoMolesPerLiter(AMOUNT_OF_SUBSTANCE.picomoles, VOLUME.liters),
  picoMolesPerDeciLiter(AMOUNT_OF_SUBSTANCE.picomoles, VOLUME.deciliters),
  picoMolesPerMilliLiter(AMOUNT_OF_SUBSTANCE.picomoles, VOLUME.milliliters),
  femtoMolesPerMilliLiter(AMOUNT_OF_SUBSTANCE.femtomoles, VOLUME.milliliters),
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
    MOLAR_VOLUME.molesPerMilliLiter: 'mol/ml',
    MOLAR_VOLUME.molesPerCubicMeter: 'mol/m³',
    MOLAR_VOLUME.milliMolesPerLiter: 'mmol/l',
    MOLAR_VOLUME.milliMolesPerDeciLiter: 'mmol/dl',
    MOLAR_VOLUME.microMolesPerLiter: 'µmol/l',
    MOLAR_VOLUME.microMolesPerDeciLiter: 'µmol/dl',
    MOLAR_VOLUME.microMolesPerMilliLiter: 'µmol/ml',
    MOLAR_VOLUME.nanoMolesPerLiter: 'nmol/l',
    MOLAR_VOLUME.nanoMolesPerDeciLiter: 'nmol/dl',
    MOLAR_VOLUME.nanoMolesPerMilliLiter: 'nl/ml',
    MOLAR_VOLUME.picoMolesPerLiter: 'pmol/l',
    MOLAR_VOLUME.picoMolesPerDeciLiter: 'pmol/dl',
    MOLAR_VOLUME.picoMolesPerMilliLiter: 'pmol/ml',
    MOLAR_VOLUME.femtoMolesPerMilliLiter: 'fmol/ml',
  };

  ///Class for molar volume conversions, e.g. if you want to convert 1 gram per liter
  ///in kilograms per liter:
  ///```dart
  ///var molarVolume = MolarVolume(removeTrailingZeros: false);
  ///molarVolume.convert(Unit(MOLAR_VOLUME.gramsPerLiter, value: 1));
  ///print(MOLAR_VOLUME.kilogramsPerLiter);
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
  Unit get molesPerMilliLiter => getUnit(MOLAR_VOLUME.molesPerMilliLiter);
  Unit get molesPerCubicMeter => getUnit(MOLAR_VOLUME.molesPerCubicMeter);
  Unit get milliMolesPerLiter => getUnit(MOLAR_VOLUME.milliMolesPerLiter);
  Unit get milliMolesPerDeciLiter =>
      getUnit(MOLAR_VOLUME.milliMolesPerDeciLiter);
  Unit get microMolesPerLiter => getUnit(MOLAR_VOLUME.microMolesPerLiter);
  Unit get microMolesPerDeciLiter =>
      getUnit(MOLAR_VOLUME.microMolesPerDeciLiter);
  Unit get microMolesPerMilliLiter =>
      getUnit(MOLAR_VOLUME.microMolesPerMilliLiter);
  Unit get nanoMolesPerLiter => getUnit(MOLAR_VOLUME.nanoMolesPerLiter);
  Unit get nanoMolesPerDeciLiter => getUnit(MOLAR_VOLUME.nanoMolesPerDeciLiter);
  Unit get nanoMolesPerMilliLiter =>
      getUnit(MOLAR_VOLUME.nanoMolesPerMilliLiter);
  Unit get picoMolesPerLiter => getUnit(MOLAR_VOLUME.picoMolesPerLiter);
  Unit get picoMolesPerDeciLiter => getUnit(MOLAR_VOLUME.picoMolesPerDeciLiter);
  Unit get picoMolesPerMilliLiter =>
      getUnit(MOLAR_VOLUME.picoMolesPerMilliLiter);
  Unit get femtoMolesPerMilliLiter =>
      getUnit(MOLAR_VOLUME.femtoMolesPerMilliLiter);
}
