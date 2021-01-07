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

class Force {
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
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for force conversions, e.g. if you want to convert 1 newton in pound force:
  ///```dart
  ///var force = Force(removeTrailingZeros: false);
  ///force.Convert(Unit(FORCE.newton, value: 1));
  ///print(FORCE.pound_force);
  /// ```
  Force({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    FORCE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: FORCE.newton, leafNodes: [
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
  void Convert(FORCE name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < FORCE.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(FORCE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get newton => _getUnit(FORCE.newton);
  Unit get dyne => _getUnit(FORCE.dyne);
  Unit get pound_force => _getUnit(FORCE.pound_force);
  Unit get kilogram_force => _getUnit(FORCE.kilogram_force);
  Unit get poundal => _getUnit(FORCE.poundal);

  ///Returns all the force units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
