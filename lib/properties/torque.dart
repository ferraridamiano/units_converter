import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available TORQUE units
enum TORQUE {
  newtonMeter,
  dyneMeter,
  poundForceFeet,
  kilogramForceMeter,
  poundalMeter,
}

class Torque extends CustomProperty {
  ///Class for torque conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var torque = Torque(removeTrailingZeros: false);
  ///torque.convert(Unit(TORQUE.square_meters, value: 1));
  ///print(TORQUE.acres);
  /// ```
  Torque(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.torque,
          mapSymbols: {
            TORQUE.newtonMeter: 'N·m',
            TORQUE.dyneMeter: 'dyn·m',
            TORQUE.poundForceFeet: 'lbf·ft',
            TORQUE.kilogramForceMeter: 'kgf·m',
            TORQUE.poundalMeter: 'pdl·m',
          },
          conversionTree: ConversionNode(name: TORQUE.newtonMeter, leafNodes: [
            ConversionNode(
              coefficientProduct: Rational.parse('1e-5'),
              name: TORQUE.dyneMeter,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('1.35581794902490555'),
              name: TORQUE.poundForceFeet,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('9.807'),
              name: TORQUE.kilogramForceMeter,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('0.138254954376'),
              name: TORQUE.poundalMeter,
            ),
          ]),
        );

  Unit get newtonMeter => getUnit(TORQUE.newtonMeter);
  Unit get dyneMeter => getUnit(TORQUE.dyneMeter);
  Unit get poundForceFeet => getUnit(TORQUE.poundForceFeet);
  Unit get kilogramForceMeter => getUnit(TORQUE.kilogramForceMeter);
  Unit get poundalMeter => getUnit(TORQUE.poundalMeter);
}
