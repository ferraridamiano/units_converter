import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

class SimpleCustomConversion extends Property<dynamic, double> {
  //Map between units and its symbol
  final Map<dynamic, String>? mapSymbols;
  final Map<dynamic, double> mapConversion;
  int significantFigures;
  bool removeTrailingZeros;

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
  ///customConversion.convert('EUR', 1);
  ///Unit usd = customConversion.getUnit('USD');
  ///print('1€ = ${usd.stringValue}${usd.symbol}');
  /// ```
  SimpleCustomConversion(this.mapConversion,
      {this.mapSymbols, this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = mapConversion.length;
    this.name = name;
    assert(mapConversion.containsValue(1), 'One conversion coefficient must be 1, this will considered the base unit');
    if (mapSymbols != null) {
      for (var val in mapConversion.keys) {
        assert(mapSymbols!.keys.contains(val), 'The key of mapConversion must be the same key of mapSymbols');
      }
    }
    for (var val in mapConversion.keys) {
      unitList.add(Unit(val, symbol: mapSymbols != null ? mapSymbols![val] : null));
    }
    var baseUnit = mapConversion.keys.firstWhere((element) => mapConversion[element] == 1); //take the base unit
    List<Node> leafNodes = [];
    mapConversion.forEach((key, value) {
      if (key != baseUnit) {
        //I'm just interested in the relationship between the base unit and the other units.
        leafNodes.add(Node(name: key, coefficientProduct: 1 / value));
      }
    });
    unitConversion = Node(name: baseUnit, leafNodes: leafNodes);
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name and value to all other units
  @override
  void convert(var name, double? value) {
    assert(mapConversion.keys.contains(name));
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < mapConversion.length; i++) {
      unitList[i].value = getNodeByName(mapConversion.keys.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }
}