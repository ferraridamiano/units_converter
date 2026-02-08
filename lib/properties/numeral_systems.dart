import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

/// Available numeral systems units
// ignore: camel_case_types
enum NUMERAL_SYSTEMS {
  decimal,
  hexadecimal,
  octal,
  binary,
}

class NumeralSystems extends Property<NUMERAL_SYSTEMS, String> {
  late ConversionNode<NUMERAL_SYSTEMS> conversionTree;
  //Map between units and its symbol
  static const Map<NUMERAL_SYSTEMS, String> mapSymbols = {
    NUMERAL_SYSTEMS.decimal: '₁₀',
    NUMERAL_SYSTEMS.hexadecimal: '₁₆',
    NUMERAL_SYSTEMS.octal: '₈',
    NUMERAL_SYSTEMS.binary: '₂',
  };

  final List<Unit> _unitList = [];

  ///Class for numeralSystems conversions, e.g. if you want to convert 10 (decimal) in binary:
  ///```dart
  ///var numeralSystems = NumeralSystems();
  ///numeralSystems.convert(Unit(NUMERAL_SYSTEMS.decimal, stringValue: '10'));
  ///print(NUMERAL_SYSTEMS.binary.stringValue);
  /// ```
  NumeralSystems({dynamic name}) {
    this.name = name ?? PROPERTY.numeralSystems;
    size = NUMERAL_SYSTEMS.values.length;
    mapSymbols.forEach((key, value) => _unitList.add(Unit(key, symbol: value)));
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

    const Map<NUMERAL_SYSTEMS, int> bases = {
      NUMERAL_SYSTEMS.decimal: 10,
      NUMERAL_SYSTEMS.hexadecimal: 16,
      NUMERAL_SYSTEMS.octal: 8,
      NUMERAL_SYSTEMS.binary: 2,
    };

    _unitList.singleWhere((e) => e.name == name).stringValue = value;
    if (name == NUMERAL_SYSTEMS.decimal) {
      for (var base in bases.keys.where((e) => e != NUMERAL_SYSTEMS.decimal)) {
        _unitList.singleWhere((e) => e.name == base).stringValue =
            decToBase(value, bases[base]!);
      }
    } else {
      final decimal = baseToDec(value, bases[name]!);
      _unitList
          .singleWhere((e) => e.name == NUMERAL_SYSTEMS.decimal)
          .stringValue = decimal;
      for (var base in bases.keys
          .where((e) => e != NUMERAL_SYSTEMS.decimal && e != name)) {
        _unitList.singleWhere((e) => e.name == base).stringValue =
            decToBase(decimal, bases[base]!);
      }
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
