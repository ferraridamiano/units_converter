/*import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

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

  ///Class for numeralSystems conversions, e.g. if you want to convert 10 (decimal) in binary:
  ///```dart
  ///var numeralSystems = NumeralSystems();
  ///numeralSystems.convert(Unit(NUMERAL_SYSTEMS.decimal, stringValue: '10'));
  ///print(NUMERAL_SYSTEMS.binary.stringValue);
  /// ```
  NumeralSystems({name}) {
    size = NUMERAL_SYSTEMS.values.length;
    this.name = name ?? PROPERTY.numeralSystems;
    for (NUMERAL_SYSTEMS val in NUMERAL_SYSTEMS.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: NUMERAL_SYSTEMS.decimal, base: 10, leafNodes: [
      Node(
        conversionType: baseConversion,
        base: 16,
        name: NUMERAL_SYSTEMS.hexadecimal,
      ),
      Node(
        conversionType: baseConversion,
        base: 8,
        name: NUMERAL_SYSTEMS.octal,
      ),
      Node(
        conversionType: baseConversion,
        base: 2,
        name: NUMERAL_SYSTEMS.binary,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. NUMERAL_SYSTEMS.decimal) and value to all other units
  @override
  void convert(NUMERAL_SYSTEMS name, String? value) {
    unitConversion.clearAllValues();
    //if the value is null also the others units are null, this is convenient to delete
    //all the other units value, for example in a unit converter app (such as Converter NOW)
    if (value == null) {
      unitConversion.clearAllValues();
      for (Unit unit in unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    unitConversion.clearSelectedNode();
    unitConversion.resetConvertedNode();
    var currentUnit = unitConversion.getByName(name);
    currentUnit?.stringValue = value;
    currentUnit?.selectedNode = true;
    currentUnit?.convertedNode = true;
    unitConversion.convert();
    for (var i = 0; i < NUMERAL_SYSTEMS.values.length; i++) {
      unitList[i].stringValue = unitConversion.getByName(NUMERAL_SYSTEMS.values.elementAt(i))?.stringValue;
    }
  }

  Unit get decimal => getUnit(NUMERAL_SYSTEMS.decimal);
  Unit get hexadecimal => getUnit(NUMERAL_SYSTEMS.hexadecimal);
  Unit get octal => getUnit(NUMERAL_SYSTEMS.octal);
  Unit get binary => getUnit(NUMERAL_SYSTEMS.binary);
}
*/