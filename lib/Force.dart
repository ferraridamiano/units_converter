import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available FORCE units
enum FORCE {
  newton,
  dyne,
  pound_force,
  kilogram_force,
  poundal,
}

class Force extends Property<FORCE, double> {
  //Map between units and its symbol
  final Map<FORCE, String> mapSymbols = {
    FORCE.newton: 'N',
    FORCE.dyne: 'dyn',
    FORCE.pound_force: 'lbf',
    FORCE.kilogram_force: 'kgf',
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
    this.name = name ?? PROPERTY.FORCE;
    FORCE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: FORCE.newton, leafNodes: [
      Node(
        coefficientProduct: 1e-5,
        name: FORCE.dyne,
      ),
      Node(
        coefficientProduct: 4.4482216152605,
        name: FORCE.pound_force,
      ),
      Node(
        coefficientProduct: 9.80665,
        name: FORCE.kilogram_force,
      ),
      Node(
        coefficientProduct: 0.138254954376,
        name: FORCE.poundal,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. FORCE.newton) and value to all other units
  @override
  void convert(FORCE name, double value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < FORCE.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(FORCE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get newton => getUnit(FORCE.newton);
  Unit get dyne => getUnit(FORCE.dyne);
  Unit get pound_force => getUnit(FORCE.pound_force);
  Unit get kilogram_force => getUnit(FORCE.kilogram_force);
  Unit get poundal => getUnit(FORCE.poundal);
}
