// ignore_for_file: camel_case_types

import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

enum MOLAR_MASS {
  gramsPerMole(MASS.grams, AMOUNT_OF_SUBSTANCE.moles),
  gramsPerMillimole(MASS.grams, AMOUNT_OF_SUBSTANCE.millimoles),
  gramsPerMicromole(MASS.grams, AMOUNT_OF_SUBSTANCE.micromoles),
  gramsPerNanomole(MASS.grams, AMOUNT_OF_SUBSTANCE.nanomoles),
  gramsPerPicomole(MASS.grams, AMOUNT_OF_SUBSTANCE.picomoles),
  gramsPerFemtomole(MASS.grams, AMOUNT_OF_SUBSTANCE.femtomoles),
  milligramsPerMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.moles),
  milligramsPerMillimole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.millimoles),
  milligramsPerMicromole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.micromoles),
  milligramsPerNanomole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.nanomoles),
  milligramsPerPicomole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.picomoles),
  milligramsPerFemtomole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.femtomoles),
  kilogramsPerMole(MASS.kilograms, AMOUNT_OF_SUBSTANCE.moles),
  kilogramsPerMillimole(MASS.kilograms, AMOUNT_OF_SUBSTANCE.millimoles),
  ;

  final MASS numerator;
  final AMOUNT_OF_SUBSTANCE denominator;
  const MOLAR_MASS(this.numerator, this.denominator);
}

class MolarMass extends RatioProperty<MOLAR_MASS, AMOUNT_OF_SUBSTANCE, MASS> {
  // NOTE: All values of MOLAR_MASS must be reported in this variable
  static const Map<MOLAR_MASS, String?> _mapSymbols = {
    MOLAR_MASS.gramsPerMole: 'g/mol',
    MOLAR_MASS.gramsPerMillimole: 'g/mmol',
    MOLAR_MASS.gramsPerMicromole: 'g/µmol',
    MOLAR_MASS.gramsPerNanomole: 'g/nmol',
    MOLAR_MASS.gramsPerPicomole: 'g/pmol',
    MOLAR_MASS.gramsPerFemtomole: 'g/fmol',
    MOLAR_MASS.milligramsPerMole: 'mg/mol',
    MOLAR_MASS.milligramsPerMillimole: 'mg/mmol',
    MOLAR_MASS.milligramsPerMicromole: 'mg/µmol',
    MOLAR_MASS.milligramsPerNanomole: 'mg/nmol',
    MOLAR_MASS.milligramsPerPicomole: 'mg/pmol',
    MOLAR_MASS.milligramsPerFemtomole: 'mg/fmol',
    MOLAR_MASS.kilogramsPerMole: 'kg/mol',
    MOLAR_MASS.kilogramsPerMillimole: 'kg/mmol',
  };

  ///Class for molar mass conversions, e.g. if you want to convert 1 gram per mole
  /// to kilograms per mole:
  ///```dart
  ///var molarMass = MolarMass(removeTrailingZeros: false);
  ///molarMass.convert(Unit(MOLAR_MASS.gramsPerMole, value: 1));
  ///print(MOLAR_MASS.kilogramsPerMole);
  /// ```
  MolarMass(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : assert(_mapSymbols.length == MOLAR_MASS.values.length),
        super(
            name: name ?? PROPERTY.molarmass,
            numeratorProperty:
                getPropertyFromEnum(MOLAR_MASS.values[0].numerator)!,
            denominatorProperty:
                getPropertyFromEnum(MOLAR_MASS.values[0].denominator)!,
            mapSymbols: _mapSymbols);

  Unit get gramsPerMole => getUnit(MOLAR_MASS.gramsPerMole);
  Unit get gramsPerMillimole => getUnit(MOLAR_MASS.gramsPerMillimole);
  Unit get gramsPerMicromole => getUnit(MOLAR_MASS.gramsPerMicromole);
  Unit get gramsPerNanomole => getUnit(MOLAR_MASS.gramsPerNanomole);
  Unit get gramsPerPicomole => getUnit(MOLAR_MASS.gramsPerPicomole);
  Unit get gramsPerFemtomole => getUnit(MOLAR_MASS.gramsPerFemtomole);
  Unit get milligramsPerMole => getUnit(MOLAR_MASS.milligramsPerMole);
  Unit get milligramsPerMillimole => getUnit(MOLAR_MASS.milligramsPerMillimole);
  Unit get milligramsPerMicromole => getUnit(MOLAR_MASS.milligramsPerMicromole);
  Unit get milligramsPerNanomole => getUnit(MOLAR_MASS.milligramsPerNanomole);
  Unit get milligramsPerPicomole => getUnit(MOLAR_MASS.milligramsPerPicomole);
  Unit get milligramsPerFemtomole => getUnit(MOLAR_MASS.milligramsPerFemtomole);
  Unit get kilogramsPerMole => getUnit(MOLAR_MASS.kilogramsPerMole);
  Unit get kilogramsPerMillimole => getUnit(MOLAR_MASS.kilogramsPerMillimole);
}
