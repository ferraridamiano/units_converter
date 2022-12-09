// ignore_for_file: camel_case_types

import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

enum RECIPROCAL_OF_MOLAR_MASS {
  molesPerGram(AMOUNT_OF_SUBSTANCE.moles, MASS.grams),
  milliMolesPerGram(AMOUNT_OF_SUBSTANCE.millimoles, MASS.grams),
  microMolesPerGram(AMOUNT_OF_SUBSTANCE.micromoles, MASS.grams),
  nanoMolesPerGram(AMOUNT_OF_SUBSTANCE.nanomoles, MASS.grams),
  picoMolesPerGram(AMOUNT_OF_SUBSTANCE.picomoles, MASS.grams),
  femtoMolesPerGram(AMOUNT_OF_SUBSTANCE.femtomoles, MASS.grams),
  molesPerMilliGram(AMOUNT_OF_SUBSTANCE.moles, MASS.milligrams),
  milliMolesPerMilliGram(AMOUNT_OF_SUBSTANCE.millimoles, MASS.milligrams),
  microMolesPerMilliGram(AMOUNT_OF_SUBSTANCE.micromoles, MASS.milligrams),
  nanoMolesPerMilliGram(AMOUNT_OF_SUBSTANCE.nanomoles, MASS.milligrams),
  picoMolesPerMilliGram(AMOUNT_OF_SUBSTANCE.picomoles, MASS.milligrams),
  femtoMolesPerMilliGram(AMOUNT_OF_SUBSTANCE.femtomoles, MASS.milligrams),
  molesPerKiloGram(AMOUNT_OF_SUBSTANCE.moles, MASS.kilograms),
  milliMolesPerKiloGram(AMOUNT_OF_SUBSTANCE.millimoles, MASS.kilograms),
  ;

  final AMOUNT_OF_SUBSTANCE numerator;
  final MASS denominator;
  const RECIPROCAL_OF_MOLAR_MASS(this.numerator, this.denominator);
}

class ReciprocalOfMolarMass
    extends RatioProperty<RECIPROCAL_OF_MOLAR_MASS, AMOUNT_OF_SUBSTANCE, MASS> {
  // NOTE: All values of RECIPROCAL_OF_MOLAR_MASS must be reported in this variable
  static const Map<RECIPROCAL_OF_MOLAR_MASS, String?> _mapSymbols = {
    RECIPROCAL_OF_MOLAR_MASS.molesPerGram: 'mol/g',
    RECIPROCAL_OF_MOLAR_MASS.milliMolesPerGram: 'mmol/g',
    RECIPROCAL_OF_MOLAR_MASS.microMolesPerGram: 'µmol/g',
    RECIPROCAL_OF_MOLAR_MASS.nanoMolesPerGram: 'nmol/g',
    RECIPROCAL_OF_MOLAR_MASS.femtoMolesPerGram: 'fmol/g',
    RECIPROCAL_OF_MOLAR_MASS.picoMolesPerGram: 'pmol/g',
    RECIPROCAL_OF_MOLAR_MASS.molesPerMilliGram: 'mol/mg',
    RECIPROCAL_OF_MOLAR_MASS.milliMolesPerMilliGram: 'mmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.microMolesPerMilliGram: 'µmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.nanoMolesPerMilliGram: 'nmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.picoMolesPerMilliGram: 'pmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.femtoMolesPerMilliGram: 'fmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.molesPerKiloGram: 'mol/kg',
    RECIPROCAL_OF_MOLAR_MASS.milliMolesPerKiloGram: 'mmol/kg',
  };

  ///Class for the reciprocal of molar mass conversions, e.g. if you want to
  ///convert 1 gram per liter into kilograms per liter:
  ///```dart
  ///var reciprocalOfMolarMass = MolarMass(removeTrailingZeros: false);
  ///reciprocalOfMolarMass.convert(Unit(RECIPROCAL_OF_MOLAR_MASS.gramsPerLiter, value: 1));
  ///print(RECIPROCAL_OF_MOLAR_MASS.kilogramsPerLiter);
  /// ```
  ReciprocalOfMolarMass(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : assert(_mapSymbols.length == RECIPROCAL_OF_MOLAR_MASS.values.length),
        super(
            name: name ?? PROPERTY.reciprocalofmolarmass,
            numeratorProperty: getPropertyFromEnum(
                RECIPROCAL_OF_MOLAR_MASS.values[0].numerator)!,
            denominatorProperty: getPropertyFromEnum(
                RECIPROCAL_OF_MOLAR_MASS.values[0].denominator)!,
            mapSymbols: _mapSymbols);

  Unit get molesPerGram => getUnit(RECIPROCAL_OF_MOLAR_MASS.molesPerGram);
  Unit get milliMolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.milliMolesPerGram);
  Unit get microMolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.microMolesPerGram);
  Unit get nanoMolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.nanoMolesPerGram);
  Unit get picoMolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.picoMolesPerGram);
  Unit get femtoMolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.femtoMolesPerGram);
  Unit get molesPerMilliGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.molesPerMilliGram);
  Unit get milliMolesPerMilliGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.milliMolesPerMilliGram);
  Unit get microMolesPerMilliGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.microMolesPerMilliGram);
  Unit get nanoMolesPerMilliGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.nanoMolesPerMilliGram);
  Unit get picoMolesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.picoMolesPerMilliGram);
  Unit get femtoMolesPerMilliGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.femtoMolesPerMilliGram);
  Unit get molesPerKiloGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.molesPerKiloGram);
  Unit get milliMolesPerKiloGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.milliMolesPerKiloGram);
}
