import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

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
    this.name = name ?? PROPERTY.NUMERAL_SYSTEMS;
    NUMERAL_SYSTEMS.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: NUMERAL_SYSTEMS.decimal, base: 10, leafNodes: [
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

  ///Converts a unit with a specific name (e.g. NUMERAL_SYSTEMS.decimal) and value to all other units
  @override
  void convert(NUMERAL_SYSTEMS name, String? value) {
    unit_conversion.clearAllValues();
    //if the value is null also the others units are null, this is convenient to delete
    //all the other units value, for example in a unit converter app (such as Converter NOW)
    if (value == null) {
      unit_conversion.clearAllValues();
      for (Unit unit in unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    unit_conversion.clearSelectedNode();
    unit_conversion.resetConvertedNode();
    var currentUnit = unit_conversion.getByName(name);
    currentUnit?.stringValue = value;
    currentUnit?.selectedNode = true;
    currentUnit?.convertedNode = true;
    unit_conversion.convert();
    for (var i = 0; i < NUMERAL_SYSTEMS.values.length; i++) {
      unitList[i].stringValue = unit_conversion.getByName(NUMERAL_SYSTEMS.values.elementAt(i))?.stringValue;
    }
  }

  Unit get decimal => getUnit(NUMERAL_SYSTEMS.decimal);
  Unit get hexadecimal => getUnit(NUMERAL_SYSTEMS.hexadecimal);
  Unit get octal => getUnit(NUMERAL_SYSTEMS.octal);
  Unit get binary => getUnit(NUMERAL_SYSTEMS.binary);
}
