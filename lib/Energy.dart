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
  List<Unit> areaUnitList = [];
  Node _energy_conversion;

  ///Class for energy conversions, e.g. if you want to convert 1 joule in kilowatt hours:
  ///```dart
  ///var energy = Energy(removeTrailingZeros: false);
  ///energy.Convert(Unit(ENERGY.joules, value: 1));
  ///print(ENERGY.kilowatt_hours);
  /// ```
  Energy({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    ENERGY.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _energy_conversion = Node(name: ENERGY.joules, leafNodes: [
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

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(ENERGY.values.contains(unit.name));
    _energy_conversion.clearAllValues();
    _energy_conversion.clearSelectedNode();
    var currentUnit = _energy_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _energy_conversion.convert();
    for (var i = 0; i < ENERGY.values.length; i++) {
      areaUnitList[i].value = _energy_conversion.getByName(ENERGY.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get joules => _getUnit(ENERGY.joules);
  Unit get calories => _getUnit(ENERGY.calories);
  Unit get kilowatt_hours => _getUnit(ENERGY.kilowatt_hours);
  Unit get electronvolts => _getUnit(ENERGY.electronvolts);

  ///Returns all the energy units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
