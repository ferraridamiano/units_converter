import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils_conversion.dart';

//Available TORQUE units
enum TORQUE {
  newtonMeter,
  dyneMeter,
  poundForceFeet,
  kilogramForceMeter,
  poundalMeter,
}

class Torque extends Property<TORQUE, double> {
  //Map between units and its symbol
  final Map<TORQUE, String> mapSymbols = {
    TORQUE.newtonMeter: 'N·m',
    TORQUE.dyneMeter: 'dyn·m',
    TORQUE.poundForceFeet: 'lbf·ft',
    TORQUE.kilogramForceMeter: 'kgf·m',
    TORQUE.poundalMeter: 'pdl·m',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for torque conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var torque = Torque(removeTrailingZeros: false);
  ///torque.convert(Unit(TORQUE.square_meters, value: 1));
  ///print(TORQUE.acres);
  /// ```
  Torque({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = TORQUE.values.length;
    this.name = name ?? PROPERTY.torque;
    for (TORQUE val in TORQUE.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: TORQUE.newtonMeter, leafNodes: [
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
  }

  ///Converts a unit with a specific name (e.g. TORQUE.newton_meter) and value to all other units
  @override
  void convert(TORQUE name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < TORQUE.values.length; i++) {
      unitList[i].value = unitConversion.getByName(TORQUE.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get newtonMeter => getUnit(TORQUE.newtonMeter);
  Unit get dyneMeter => getUnit(TORQUE.dyneMeter);
  Unit get poundForceFeet => getUnit(TORQUE.poundForceFeet);
  Unit get kilogramForceMeter => getUnit(TORQUE.kilogramForceMeter);
  Unit get poundalMeter => getUnit(TORQUE.poundalMeter);
}
