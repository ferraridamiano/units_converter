// ignore_for_file: camel_case_types

import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

enum RECIPROCAL_OF_MOLAR_MASS {
  molesPerGram(AMOUNT_OF_SUBSTANCE.moles, MASS.grams),
  millimolesPerGram(AMOUNT_OF_SUBSTANCE.millimoles, MASS.grams),
  micromolesPerGram(AMOUNT_OF_SUBSTANCE.micromoles, MASS.grams),
  nanomolesPerGram(AMOUNT_OF_SUBSTANCE.nanomoles, MASS.grams),
  picomolesPerGram(AMOUNT_OF_SUBSTANCE.picomoles, MASS.grams),
  femtomolesPerGram(AMOUNT_OF_SUBSTANCE.femtomoles, MASS.grams),
  molesPerMilligram(AMOUNT_OF_SUBSTANCE.moles, MASS.milligrams),
  millimolesPerMilligram(AMOUNT_OF_SUBSTANCE.millimoles, MASS.milligrams),
  micromolesPerMilligram(AMOUNT_OF_SUBSTANCE.micromoles, MASS.milligrams),
  nanomolesPerMilligram(AMOUNT_OF_SUBSTANCE.nanomoles, MASS.milligrams),
  picomolesPerMilligram(AMOUNT_OF_SUBSTANCE.picomoles, MASS.milligrams),
  femtomolesPerMilligram(AMOUNT_OF_SUBSTANCE.femtomoles, MASS.milligrams),
  molesPerKilogram(AMOUNT_OF_SUBSTANCE.moles, MASS.kilograms),
  millimolesPerKilogram(AMOUNT_OF_SUBSTANCE.millimoles, MASS.kilograms);

  final AMOUNT_OF_SUBSTANCE numerator;
  final MASS denominator;
  const RECIPROCAL_OF_MOLAR_MASS(this.numerator, this.denominator);
}

class ReciprocalOfMolarMass
    extends RatioProperty<RECIPROCAL_OF_MOLAR_MASS, AMOUNT_OF_SUBSTANCE, MASS> {
  // NOTE: All values of RECIPROCAL_OF_MOLAR_MASS must be reported in this variable
  static const Map<RECIPROCAL_OF_MOLAR_MASS, String?> _mapSymbols = {
    RECIPROCAL_OF_MOLAR_MASS.molesPerGram: 'mol/g',
    RECIPROCAL_OF_MOLAR_MASS.millimolesPerGram: 'mmol/g',
    RECIPROCAL_OF_MOLAR_MASS.micromolesPerGram: 'µmol/g',
    RECIPROCAL_OF_MOLAR_MASS.nanomolesPerGram: 'nmol/g',
    RECIPROCAL_OF_MOLAR_MASS.femtomolesPerGram: 'fmol/g',
    RECIPROCAL_OF_MOLAR_MASS.picomolesPerGram: 'pmol/g',
    RECIPROCAL_OF_MOLAR_MASS.molesPerMilligram: 'mol/mg',
    RECIPROCAL_OF_MOLAR_MASS.millimolesPerMilligram: 'mmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.micromolesPerMilligram: 'µmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.nanomolesPerMilligram: 'nmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.picomolesPerMilligram: 'pmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.femtomolesPerMilligram: 'fmol/mg',
    RECIPROCAL_OF_MOLAR_MASS.molesPerKilogram: 'mol/kg',
    RECIPROCAL_OF_MOLAR_MASS.millimolesPerKilogram: 'mmol/kg',
  };

  ///Class for the reciprocal of molar mass conversions, e.g. if you want to
  ///convert 1 mole per gram to moles per milligram:
  ///```dart
  ///var reciprocalOfMolarMass = MolarMass(removeTrailingZeros: false);
  ///reciprocalOfMolarMass.convert(Unit(RECIPROCAL_OF_MOLAR_MASS.molesPerGram, value: 1));
  ///print(RECIPROCAL_OF_MOLAR_MASS.molesPerMilligram);
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
  Unit get millimolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.millimolesPerGram);
  Unit get micromolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.micromolesPerGram);
  Unit get nanomolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.nanomolesPerGram);
  Unit get picomolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.picomolesPerGram);
  Unit get femtomolesPerGram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.femtomolesPerGram);
  Unit get molesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.molesPerMilligram);
  Unit get millimolesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.millimolesPerMilligram);
  Unit get micromolesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.micromolesPerMilligram);
  Unit get nanomolesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.nanomolesPerMilligram);
  Unit get picomolesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.picomolesPerMilligram);
  Unit get femtomolesPerMilligram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.femtomolesPerMilligram);
  Unit get molesPerKilogram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.molesPerKilogram);
  Unit get millimolesPerKilogram =>
      getUnit(RECIPROCAL_OF_MOLAR_MASS.millimolesPerKilogram);
}
