import 'UtilsConversion.dart';
import 'Unit.dart';

//Available ENERGY units
enum ENERGY {
  joules,
  calories,
  kilowatt_hours,
  electronvolts,
}

class Energy {
  //Map between units and its symbol
  final Map<ENERGY, String> mapSymbols = {
    ENERGY.joules: 'J',
    ENERGY.calories: 'cal',
    ENERGY.kilowatt_hours: 'kwh',
    ENERGY.electronvolts: 'eV',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for energy conversions, e.g. if you want to convert 1 joule in kilowatt hours:
  ///```dart
  ///var energy = Energy(removeTrailingZeros: false);
  ///energy.Convert(Unit(ENERGY.joules, value: 1));
  ///print(ENERGY.kilowatt_hours);
  /// ```
  Energy({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    ENERGY.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: ENERGY.joules, leafNodes: [
      Node(
        coefficientProduct: 4.1867999409,
        name: ENERGY.calories,
      ),
      Node(
        coefficientProduct: 3600000.0,
        name: ENERGY.kilowatt_hours,
      ),
      Node(
        coefficientProduct: 1.60217646e-19,
        name: ENERGY.electronvolts,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. ENERGY.calories) and value to all other units
  void Convert(ENERGY name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < ENERGY.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(ENERGY.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get joules => _getUnit(ENERGY.joules);
  Unit get calories => _getUnit(ENERGY.calories);
  Unit get kilowatt_hours => _getUnit(ENERGY.kilowatt_hours);
  Unit get electronvolts => _getUnit(ENERGY.electronvolts);

  ///Returns all the energy units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
