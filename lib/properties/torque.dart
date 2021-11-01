import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available TORQUE units
enum TORQUE {
  newtonMeter,
  dyneMeter,
  poundForceFeet,
  kilogramForceMeter,
  poundalMeter,
}

class Torque extends Property<TORQUE, double> {
  /// Map between units and its symbol
  static const Map<TORQUE, String?> mapSymbols = {
    TORQUE.newtonMeter: 'N·m',
    TORQUE.dyneMeter: 'dyn·m',
    TORQUE.poundForceFeet: 'lbf·ft',
    TORQUE.kilogramForceMeter: 'kgf·m',
    TORQUE.poundalMeter: 'pdl·m',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for torque conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var torque = Torque(removeTrailingZeros: false);
  ///torque.convert(Unit(TORQUE.square_meters, value: 1));
  ///print(TORQUE.acres);
  /// ```
  Torque(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: TORQUE.newtonMeter, leafNodes: [
      Node(
        coefficientProduct: 1e-5,
        name: TORQUE.dyneMeter,
      ),
      Node(
        coefficientProduct: 1.35581794902490555,
        name: TORQUE.poundForceFeet,
      ),
      Node(
        coefficientProduct: 9.807,
        name: TORQUE.kilogramForceMeter,
      ),
      Node(
        coefficientProduct: 0.138254954376,
        name: TORQUE.poundalMeter,
      ),
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. TORQUE.newton_meter) and value to all other units
  @override
  void convert(TORQUE name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get newtonMeter => getUnit(TORQUE.newtonMeter);
  Unit get dyneMeter => getUnit(TORQUE.dyneMeter);
  Unit get poundForceFeet => getUnit(TORQUE.poundForceFeet);
  Unit get kilogramForceMeter => getUnit(TORQUE.kilogramForceMeter);
  Unit get poundalMeter => getUnit(TORQUE.poundalMeter);
}
