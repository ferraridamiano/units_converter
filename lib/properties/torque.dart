import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

//Available TORQUE units
enum TORQUE {
  newtonMeter,
  dyneMeter,
  poundForceFeet,
  poundForceInch,
  kilogramForceMeter,
  poundalMeter,
}

class Torque extends DoubleProperty<TORQUE> {
  ///Class for torque conversions, e.g. if you want to convert 1 newton meter in pound-force feet:
  ///```dart
  ///var torque = Torque(removeTrailingZeros: false);
  ///torque.convert(Unit(TORQUE.newtonMeter, value: 1));
  ///print(TORQUE.poundForceFeet);
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
            TORQUE.poundForceInch: 'lbf·in',
            TORQUE.kilogramForceMeter: 'kgf·m',
            TORQUE.poundalMeter: 'pdl·m',
          },
          conversionTree: ConversionNode(name: TORQUE.newtonMeter, leafNodes: [
            ConversionNode(
              coefficientProduct: 1e-5,
              name: TORQUE.dyneMeter,
            ),
            ConversionNode(
              coefficientProduct: 1.35581794902490555,
              name: TORQUE.poundForceFeet,
            ),
            ConversionNode(
              coefficientProduct: 0.1129848290854088,
              name: TORQUE.poundForceInch,
            ),
            ConversionNode(
              coefficientProduct: 9.807,
              name: TORQUE.kilogramForceMeter,
            ),
            ConversionNode(
              coefficientProduct: 0.138254954376,
              name: TORQUE.poundalMeter,
            ),
          ]),
        );

  Unit get newtonMeter => getUnit(TORQUE.newtonMeter);
  Unit get dyneMeter => getUnit(TORQUE.dyneMeter);
  Unit get poundForceFeet => getUnit(TORQUE.poundForceFeet);
  Unit get poundForceInch => getUnit(TORQUE.poundForceInch);
  Unit get kilogramForceMeter => getUnit(TORQUE.kilogramForceMeter);
  Unit get poundalMeter => getUnit(TORQUE.poundalMeter);
}
