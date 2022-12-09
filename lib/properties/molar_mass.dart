// ignore_for_file: camel_case_types

import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/units_converter.dart';
import 'package:units_converter/utils/utils.dart';

enum MOLAR_MASS {
  gramsPerMole(MASS.grams, AMOUNT_OF_SUBSTANCE.moles),
  gramsPerMilliMole(MASS.grams, AMOUNT_OF_SUBSTANCE.millimoles),
  gramsPerMicroMole(MASS.grams, AMOUNT_OF_SUBSTANCE.micromoles),
  gramsPerNanoMole(MASS.grams, AMOUNT_OF_SUBSTANCE.nanomoles),
  gramsPerPicoMole(MASS.grams, AMOUNT_OF_SUBSTANCE.picomoles),
  gramsPerFemtoMole(MASS.grams, AMOUNT_OF_SUBSTANCE.femtomoles),
  milliGramsPerMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.moles),
  milliGramsPerMilliMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.millimoles),
  milliGramsPerMicroMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.micromoles),
  milliGramsPerNanoMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.nanomoles),
  milliGramsPerPicoMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.picomoles),
  milliGramsPerFemtoMole(MASS.milligrams, AMOUNT_OF_SUBSTANCE.femtomoles),
  kiloGramsPerMole(MASS.kilograms, AMOUNT_OF_SUBSTANCE.moles),
  kiloGramsPerMilliMole(MASS.kilograms, AMOUNT_OF_SUBSTANCE.millimoles),
  ;

  final MASS numerator;
  final AMOUNT_OF_SUBSTANCE denominator;
  const MOLAR_MASS(this.numerator, this.denominator);
}

class MolarMass extends RatioProperty<MOLAR_MASS, AMOUNT_OF_SUBSTANCE, MASS> {
  // NOTE: All values of MOLAR_MASS must be reported in this variable
  static const Map<MOLAR_MASS, String?> _mapSymbols = {
    MOLAR_MASS.gramsPerMole: 'g/mol',
    MOLAR_MASS.gramsPerMilliMole: 'g/mmol',
    MOLAR_MASS.gramsPerMicroMole: 'g/µmol',
    MOLAR_MASS.gramsPerNanoMole: 'g/nmol',
    MOLAR_MASS.gramsPerPicoMole: 'g/pmol',
    MOLAR_MASS.gramsPerFemtoMole: 'g/fmol',
    MOLAR_MASS.milliGramsPerMole: 'mg/mol',
    MOLAR_MASS.milliGramsPerMilliMole: 'mg/mmol',
    MOLAR_MASS.milliGramsPerMicroMole: 'mg/µmol',
    MOLAR_MASS.milliGramsPerNanoMole: 'mg/nmol',
    MOLAR_MASS.milliGramsPerPicoMole: 'mg/pmol',
    MOLAR_MASS.milliGramsPerFemtoMole: 'mg/fmol',
    MOLAR_MASS.kiloGramsPerMole: 'kg/mol',
    MOLAR_MASS.kiloGramsPerMilliMole: 'kg/mmol',
  };

  ///Class for molar mass conversions, e.g. if you want to convert 1 gram per liter
  ///in kilograms per liter:
  ///```dart
  ///var molarMass = MolarMass(removeTrailingZeros: false);
  ///molarMass.convert(Unit(MOLAR_MASS.gramsPerLiter, value: 1));
  ///print(MOLAR_MASS.kilogramsPerLiter);
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
  Unit get gramsPerMilliMole => getUnit(MOLAR_MASS.gramsPerMilliMole);
  Unit get gramsPerMicroMole => getUnit(MOLAR_MASS.gramsPerMicroMole);
  Unit get gramsPerNanoMole => getUnit(MOLAR_MASS.gramsPerNanoMole);
  Unit get gramsPerPicoMole => getUnit(MOLAR_MASS.gramsPerPicoMole);
  Unit get gramsPerFemtoMole => getUnit(MOLAR_MASS.gramsPerFemtoMole);
  Unit get milliGramsPerMole => getUnit(MOLAR_MASS.milliGramsPerMole);
  Unit get milliGramsPerMilliMole => getUnit(MOLAR_MASS.milliGramsPerMilliMole);
  Unit get milliGramsPerMicroMole => getUnit(MOLAR_MASS.milliGramsPerMicroMole);
  Unit get milliGramsPerNanoMole => getUnit(MOLAR_MASS.milliGramsPerNanoMole);
  Unit get milliGramsPerPicoMole => getUnit(MOLAR_MASS.milliGramsPerPicoMole);
  Unit get milliGramsPerFemtoMole => getUnit(MOLAR_MASS.milliGramsPerFemtoMole);
  Unit get kiloGramsPerMole => getUnit(MOLAR_MASS.kiloGramsPerMole);
  Unit get kiloGramsPerMilliMole => getUnit(MOLAR_MASS.kiloGramsPerMilliMole);
}
