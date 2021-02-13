import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available TORQUE units
enum TORQUE {
  newton_meter,
  dyne_meter,
  pound_force_feet,
  kilogram_force_meter,
  poundal_meter,
}

class Torque extends Property<TORQUE, double> {
  //Map between units and its symbol
  final Map<TORQUE, String> mapSymbols = {
    TORQUE.newton_meter: 'N·m',
    TORQUE.dyne_meter: 'dyn·m',
    TORQUE.pound_force_feet: 'lbf·ft',
    TORQUE.kilogram_force_meter: 'kgf·m',
    TORQUE.poundal_meter: 'pdl·m',
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
    this.name = name ?? PROPERTY.TORQUE;
    TORQUE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: TORQUE.newton_meter, leafNodes: [
      Node(
        coefficientProduct: 1e-5,
        name: TORQUE.dyne_meter,
      ),
      Node(
        coefficientProduct: 1.35581794902490555,
        name: TORQUE.pound_force_feet,
      ),
      Node(
        coefficientProduct: 9.807,
        name: TORQUE.kilogram_force_meter,
      ),
      Node(
        coefficientProduct: 0.138254954376,
        name: TORQUE.poundal_meter,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. TORQUE.newton_meter) and value to all other units
  @override
  void convert(TORQUE name, double value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < TORQUE.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(TORQUE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get newton_meter => getUnit(TORQUE.newton_meter);
  Unit get dyne_meter => getUnit(TORQUE.dyne_meter);
  Unit get pound_force_feet => getUnit(TORQUE.pound_force_feet);
  Unit get kilogram_force_meter => getUnit(TORQUE.kilogram_force_meter);
  Unit get poundal_meter => getUnit(TORQUE.poundal_meter);
}
