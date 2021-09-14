import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils_conversion.dart';

//Available FORCE units
enum FORCE {
  newton,
  dyne,
  poundForce,
  kilogramForce,
  poundal,
}

class Force extends Property<FORCE, double> {
  //Map between units and its symbol
  final Map<FORCE, String> mapSymbols = {
    FORCE.newton: 'N',
    FORCE.dyne: 'dyn',
    FORCE.poundForce: 'lbf',
    FORCE.kilogramForce: 'kgf',
    FORCE.poundal: 'pdl',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for force conversions, e.g. if you want to convert 1 newton in pound force:
  ///```dart
  ///var force = Force(removeTrailingZeros: false);
  ///force.Convert(Unit(FORCE.newton, value: 1));
  ///print(FORCE.pound_force);
  /// ```
  Force({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = FORCE.values.length;
    this.name = name ?? PROPERTY.force;
    for (FORCE val in FORCE.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: FORCE.newton, leafNodes: [
      Node(
        coefficientProduct: 1e-5,
        name: FORCE.dyne,
      ),
      Node(
        coefficientProduct: 4.4482216152605,
        name: FORCE.poundForce,
      ),
      Node(
        coefficientProduct: 9.80665,
        name: FORCE.kilogramForce,
      ),
      Node(
        coefficientProduct: 0.138254954376,
        name: FORCE.poundal,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. FORCE.newton) and value to all other units
  @override
  void convert(FORCE name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < FORCE.values.length; i++) {
      unitList[i].value = unitConversion.getByName(FORCE.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get newton => getUnit(FORCE.newton);
  Unit get dyne => getUnit(FORCE.dyne);
  Unit get poundForce => getUnit(FORCE.poundForce);
  Unit get kilogramForce => getUnit(FORCE.kilogramForce);
  Unit get poundal => getUnit(FORCE.poundal);
}
