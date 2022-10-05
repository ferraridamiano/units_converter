import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

//Available length units
enum AMOUNTOFSUBSTANCE {
  moles,
  femtomoles,
  picomoles,
  nanomoles,
  micromoles,
  millimoles,
}

class AmountOfSubstance extends DoubleProperty<AMOUNTOFSUBSTANCE> {
  ///Class for amount of substance conversions, this is really just converting
  ///prefixes, but can often be used combined with other units
  ///e.g. if you want to convert 1 mole to millimoles:
  ///```dart
  ///var amountOfSubstance = AMOUNTOFSUBSTANCE(removeTrailingZeros: false);
  ///amountOfSubstance.convert(Unit(AMOUNTOFSUBSTANCE.moles, value: 1));
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
            AMOUNTOFSUBSTANCE.moles: 'mol',
            AMOUNTOFSUBSTANCE.femtomoles: 'fmol',
            AMOUNTOFSUBSTANCE.nanomoles: 'nmol',
            AMOUNTOFSUBSTANCE.micromoles: 'umol',
            AMOUNTOFSUBSTANCE.millimoles: 'mmol',
          },
          conversionTree: ConversionNode(
            name: AMOUNTOFSUBSTANCE.moles,
            leafNodes: [
              ConversionNode(
                coefficientProduct: 1e-3,
                name: AMOUNTOFSUBSTANCE.millimoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-6,
                name: AMOUNTOFSUBSTANCE.micromoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-9,
                name: AMOUNTOFSUBSTANCE.nanomoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-12,
                name: AMOUNTOFSUBSTANCE.picomoles,
              ),
              ConversionNode(
                coefficientProduct: 1e-15,
                name: AMOUNTOFSUBSTANCE.femtomoles,
              ),
            ],
          ),
        );

  Unit get moles => getUnit(AMOUNTOFSUBSTANCE.moles);
  Unit get femtomoles => getUnit(AMOUNTOFSUBSTANCE.millimoles);
  Unit get picomoles => getUnit(AMOUNTOFSUBSTANCE.picomoles);
  Unit get nanomoles => getUnit(AMOUNTOFSUBSTANCE.micromoles);
  Unit get micromoles => getUnit(AMOUNTOFSUBSTANCE.nanomoles);
  Unit get millimoles => getUnit(AMOUNTOFSUBSTANCE.femtomoles);
}
