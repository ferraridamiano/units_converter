import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

//Available NUMERAL_SYSTEMS units
enum NUMERAL_SYSTEMS {
  decimal,
  hexadecimal,
  octal,
  binary,
}

class NumeralSystems extends Property<NUMERAL_SYSTEMS, String> {
  //Map between units and its symbol
  final Map<NUMERAL_SYSTEMS, String> mapSymbols = {
    NUMERAL_SYSTEMS.decimal: '₁₀',
    NUMERAL_SYSTEMS.hexadecimal: '₁₆',
    NUMERAL_SYSTEMS.octal: '₈',
    NUMERAL_SYSTEMS.binary: '₂',
  };

  final List<Unit> _unitList = [];
  late List<Node> _nodeList;
  late Node _conversionTree;

  ///Class for numeralSystems conversions, e.g. if you want to convert 10 (decimal) in binary:
  ///```dart
  ///var numeralSystems = NumeralSystems();
  ///numeralSystems.convert(Unit(NUMERAL_SYSTEMS.decimal, stringValue: '10'));
  ///print(NUMERAL_SYSTEMS.binary.stringValue);
  /// ```
  NumeralSystems({name}) {
    _conversionTree = Node(name: NUMERAL_SYSTEMS.decimal, base: 10, leafNodes: [
      Node(
        conversionType: CONVERSION_TYPE.baseConversion,
        base: 16,
        name: NUMERAL_SYSTEMS.hexadecimal,
      ),
      Node(
        conversionType: CONVERSION_TYPE.baseConversion,
        base: 8,
        name: NUMERAL_SYSTEMS.octal,
      ),
      Node(
        conversionType: CONVERSION_TYPE.baseConversion,
        base: 2,
        name: NUMERAL_SYSTEMS.binary,
      ),
    ]);
    mapSymbols.forEach((key, value) => _unitList.add(Unit(key, symbol: value)));
    _nodeList = _conversionTree.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. NUMERAL_SYSTEMS.decimal) and value to all other units
  @override
  void convert(NUMERAL_SYSTEMS name, String? value) {
    // if the value is null also the others units are null, this is convenient
    // in order to delete all the other units value, for example in a unit
    // converter app (such as Converter NOW)
    if (value == null) {
      for (Unit unit in _unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }

    _conversionTree.convert(name, value);
    for (var i = 0; i < NUMERAL_SYSTEMS.values.length; i++) {
      _unitList[i].stringValue = _nodeList
          .singleWhere(
              (node) => node.name == NUMERAL_SYSTEMS.values.elementAt(i))
          .stringValue;
    }
  }

  ///Returns all the units converted with prefixes
  @override
  List<Unit> getAll() => _unitList;
  ///Returns the Unit with the corresponding name
  @override
  Unit getUnit(var name) =>
      _unitList.where((element) => element.name == name).single;

  Unit get decimal => getUnit(NUMERAL_SYSTEMS.decimal);
  Unit get hexadecimal => getUnit(NUMERAL_SYSTEMS.hexadecimal);
  Unit get octal => getUnit(NUMERAL_SYSTEMS.octal);
  Unit get binary => getUnit(NUMERAL_SYSTEMS.binary);
}
