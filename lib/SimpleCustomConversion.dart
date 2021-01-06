import 'package:units_converter/UtilsConversion.dart';

class SimpleCustomConversion {
  //Map between units and its symbol
  final Map<String, String> mapSymbols;
  final Map<String, double> mapConversion;
  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for area conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var area = SimpleCustomConversion(removeTrailingZeros: false);
  ///area.Convert(Unit(AREA.square_meters, value: 1));
  ///print(AREA.acres);
  /// ```
  SimpleCustomConversion(this.mapConversion, {this.mapSymbols, this.significantFigures = 10, this.removeTrailingZeros = true}) {
    assert(mapConversion.containsValue(1), 'One conversion coefficient must be 1, this will considered the base unit');
    mapConversion.keys.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols!=null ? mapSymbols[element] : null)));
    var baseUnit = mapConversion.keys.firstWhere((element) => mapConversion[element] == 1); //take the base unit
    List<Node> leafNodes = [];
    mapConversion.forEach((key, value) {
      if (key != baseUnit) {//I'm just interested in the relationship between the base unit and the other units.
        leafNodes.add(Node(name: key, coefficientProduct: 1/value));
      }
    });
    _unit_conversion = Node(name: baseUnit, leafNodes: leafNodes);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(mapConversion.keys.contains(unit.name));
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < mapConversion.length; i++) {
      unitList[i].value = _unit_conversion.getByName(mapConversion.keys.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  ///Returns all the area units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
