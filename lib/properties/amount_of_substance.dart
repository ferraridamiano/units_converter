// ignore_for_file: camel_case_types

import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available amount of substance units
enum AMOUNT_OF_SUBSTANCE {
  moles,
  millimoles,
  micromoles,
  nanomoles,
  picomoles,
  femtomoles,
}

class AmountOfSubstance extends DoubleProperty<AMOUNT_OF_SUBSTANCE> {
  ///Class for amount of substance conversions, this is really just converting
  ///prefixes, but can often be used combined with other units
  ///e.g. if you want to convert 1 mole to millimoles:
  ///```dart
  ///var amountOfSubstance = AMOUNT_OF_SUBSTANCE(removeTrailingZeros: false);
  ///amountOfSubstance.convert(AMOUNT_OF_SUBSTANCE.moles, 1);
  ///print(amountOfSubstance.millimoles);
  /// ```
  AmountOfSubstance(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.length,
          mapSymbols: {
            AMOUNT_OF_SUBSTANCE.moles: 'mol',
            AMOUNT_OF_SUBSTANCE.millimoles: 'mmol',
            AMOUNT_OF_SUBSTANCE.micromoles: 'µmol',
            AMOUNT_OF_SUBSTANCE.nanomoles: 'nmol',
            AMOUNT_OF_SUBSTANCE.picomoles: 'pmol',
            AMOUNT_OF_SUBSTANCE.femtomoles: 'fmol',
          },
          conversionTree: ConversionNode(
            name: AMOUNT_OF_SUBSTANCE.moles,
            children: [
              ConversionNode(
                coefficientProduct: 1e-3,
                name: AMOUNT_OF_SUBSTANCE.millimoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-6,
                name: AMOUNT_OF_SUBSTANCE.micromoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-9,
                name: AMOUNT_OF_SUBSTANCE.nanomoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-12,
                name: AMOUNT_OF_SUBSTANCE.picomoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-15,
                name: AMOUNT_OF_SUBSTANCE.femtomoles,
              ),
            ],
          ),
        );

  Unit get moles => getUnit(AMOUNT_OF_SUBSTANCE.moles);
  Unit get millimoles => getUnit(AMOUNT_OF_SUBSTANCE.millimoles);
  Unit get micromoles => getUnit(AMOUNT_OF_SUBSTANCE.micromoles);
  Unit get nanomoles => getUnit(AMOUNT_OF_SUBSTANCE.nanomoles);
  Unit get picomoles => getUnit(AMOUNT_OF_SUBSTANCE.picomoles);
  Unit get femtomoles => getUnit(AMOUNT_OF_SUBSTANCE.femtomoles);
}
