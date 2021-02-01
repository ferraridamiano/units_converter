import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

class SimpleCustomConversion extends Property<String, double> {
  //Map between units and its symbol
  final Map<String, String> mapSymbols;
  final Map<String, double> mapConversion;
  int significantFigures;
  bool removeTrailingZeros;
  var name;

  ///Class for simple custom conversions. E.g.:
  ///```dart
  ///final Map<String, double> conversionMap = {
  ///  'EUR': 1,
  ///  'USD': 1.2271,
  ///  'GBP': 0.9033,
  ///  'JPY': 126.25,
  ///  'CNY': 7.9315,
  ///};
  /// //Optional
  ///final Map<String, String> mapSymbols = {
  ///  'EUR': '€',
  ///  'USD': '\$',
  ///  'GBP': '₤',
  ///  'JPY': '¥',
  ///  'CNY': '¥',
  ///};
  ///var customConversion = SimpleCustomConversion(conversionMap, mapSymbols: mapSymbols);
  ///customConversion.Convert('EUR', 1);
  ///Unit usd = customConversion.getUnit('USD');
  ///print('1€ = ${usd.stringValue}${usd.symbol}');
  /// ```
  SimpleCustomConversion(this.mapConversion, {this.mapSymbols, this.significantFigures = 10, this.removeTrailingZeros = true, this.name}) {
    assert(mapConversion.containsValue(1), 'One conversion coefficient must be 1, this will considered the base unit');
    mapConversion.keys.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols!=null ? mapSymbols[element] : null)));
    var baseUnit = mapConversion.keys.firstWhere((element) => mapConversion[element] == 1); //take the base unit
    List<Node> leafNodes = [];
    mapConversion.forEach((key, value) {
      if (key != baseUnit) {//I'm just interested in the relationship between the base unit and the other units.
        leafNodes.add(Node(name: key, coefficientProduct: 1/value));
      }
    });
    unit_conversion = Node(name: baseUnit, leafNodes: leafNodes);
  }

  ///Converts a unit with a specific name and value to all other units
  @override
  void convert(String name, double value) {
    assert(mapConversion.keys.contains(name));
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < mapConversion.length; i++) {
      unitList[i].value = unit_conversion.getByName(mapConversion.keys.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  ///Returns the Unit with the corresponding name
  Unit getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
