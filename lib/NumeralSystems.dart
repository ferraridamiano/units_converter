import 'package:units_converter/UtilsConversion.dart';

//Available NUMERAL_SYSTEMS units
enum NUMERAL_SYSTEMS {
  decimal,
  hexadecimal,
  octal,
  binary,
}

class NumeralSystems {
  //Map between units and its symbol
  final Map<NUMERAL_SYSTEMS, String> mapSymbols = {
    NUMERAL_SYSTEMS.decimal: '₁₀',
    NUMERAL_SYSTEMS.hexadecimal: '₁₆',
    NUMERAL_SYSTEMS.octal: '₈',
    NUMERAL_SYSTEMS.binary: '₂',
  };
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for numeralSystems conversions, e.g. if you want to convert 10 (decimal) in binary:
  ///```dart
  ///var numeralSystems = NumeralSystems();
  ///numeralSystems.Convert(Unit(NUMERAL_SYSTEMS.decimal, stringValue: '10'));
  ///print(NUMERAL_SYSTEMS.binary.stringValue);
  /// ```
  NumeralSystems({int significantFigures = 10, bool removeTrailingZeros = true}) {
    NUMERAL_SYSTEMS.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: NUMERAL_SYSTEMS.decimal, base: 10, leafNodes: [
      Node(
        conversionType: BASE_CONVERSION,
        base: 16,
        name: NUMERAL_SYSTEMS.hexadecimal,
      ),
      Node(
        conversionType: BASE_CONVERSION,
        base: 8,
        name: NUMERAL_SYSTEMS.octal,
      ),
      Node(
        conversionType: BASE_CONVERSION,
        base: 2,
        name: NUMERAL_SYSTEMS.binary,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.stringValue != null);
    assert(NUMERAL_SYSTEMS.values.contains(unit.name));
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(unit.name);
    currentUnit.stringValue = unit.stringValue;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < NUMERAL_SYSTEMS.values.length; i++) {
      unitList[i].stringValue = _unit_conversion.getByName(NUMERAL_SYSTEMS.values.elementAt(i)).stringValue;
    }
  }

  Unit get decimal => _getUnit(NUMERAL_SYSTEMS.decimal);
  Unit get hexadecimal => _getUnit(NUMERAL_SYSTEMS.hexadecimal);
  Unit get octal => _getUnit(NUMERAL_SYSTEMS.octal);
  Unit get binary => _getUnit(NUMERAL_SYSTEMS.binary);

  ///Returns all the numeralSystems units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
