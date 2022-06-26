import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available ENERGY units
enum ENERGY {
  joules,
  calories,
  kilocalories,
  kilowattHours,
  electronvolts,
  energyFootPound,
}

class Energy extends CustomProperty {
  ///Class for energy conversions, e.g. if you want to convert 1 joule in kilowatt hours:
  ///```dart
  ///var energy = Energy(removeTrailingZeros: false);
  ///energy.convert(Unit(ENERGY.joules, value: 1));
  ///print(ENERGY.kilowatt_hours);
  /// ```
  Energy(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
            name: name ?? PROPERTY.energy,
            mapSymbols: {
              ENERGY.joules: 'J',
              ENERGY.calories: 'cal',
              ENERGY.kilocalories: 'kcal',
              ENERGY.kilowattHours: 'kwh',
              ENERGY.electronvolts: 'eV',
              ENERGY.energyFootPound: 'ft⋅lbf',
            },
            conversionTree: ConversionNode(name: ENERGY.joules, leafNodes: [
              ConversionNode(
                coefficientProduct: Rational.parse('4.1867999409'),
                name: ENERGY.calories,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000),
                    name: ENERGY.kilocalories,
                  ),
                ],
              ),
              ConversionNode(
                coefficientProduct: Rational.fromInt(3600000),
                name: ENERGY.kilowattHours,
              ),
              ConversionNode(
                coefficientProduct: Rational.parse('1.60217646e-19'),
                name: ENERGY.electronvolts,
              ),
              ConversionNode(
                coefficientProduct: Rational.parse('1.3558179483314004'),
                name: ENERGY.energyFootPound,
              ),
            ]));

  Unit get joules => getUnit(ENERGY.joules);
  Unit get calories => getUnit(ENERGY.calories);
  Unit get kilocalories => getUnit(ENERGY.kilocalories);
  Unit get kilowattHours => getUnit(ENERGY.kilowattHours);
  Unit get electronvolts => getUnit(ENERGY.electronvolts);
  Unit get energyFootPound => getUnit(ENERGY.energyFootPound);
}
