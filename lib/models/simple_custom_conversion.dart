import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

class SimpleCustomConversion extends Property<dynamic, double> {
  /// Map between units and its symbol
  Map<dynamic, String?>? mapSymbols;

  /// The Map of the values of the conversion. In this map at least one element
  /// must have a value of 1, it will be considered the base unit. E.g.:
  /// ```dart
  /// final Map<String, double> mapSymbols = {
  ///   'EUR': 1,
  ///   'USD': 1.2271,
  ///   'GBP': 0.9033,
  ///   'JPY': 126.25,
  ///   'CNY': 7.9315,
  /// };
  final Map<dynamic, double> mapConversion;

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for simple custom conversions. E.g.:
  ///```dart
  ///final Map<String, double> conversionMap = {
  ///  'EUR': 1,
  ///  'USD': 1.2271,
  ///  'GBP': 0.9033,
  ///  'JPY': 126.25,
  ///  'CNY': 7.9315,
  ///};
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
      {this.mapSymbols,
      this.significantFigures = 10,
      this.removeTrailingZeros = true,
      name}) {
    assert(mapConversion.containsValue(1),
        'One conversion coefficient must be 1, this will considered the base unit');
    if (mapSymbols != null) {
      for (var val in mapConversion.keys) {
        assert(mapSymbols!.keys.contains(val),
            'The key of mapConversion must be the same key of mapSymbols');
      }
    }
    var baseUnit = mapConversion.keys.firstWhere(
        (element) => mapConversion[element] == 1); //take the base unit
    List<Node> leafNodes = [];
    mapConversion.forEach((key, value) {
      if (key != baseUnit) {
        //I'm just interested in the relationship between the base unit and the other units.
        leafNodes.add(Node(name: key, coefficientProduct: 1 / value));
      }
    });
    if (mapSymbols == null) {
      mapSymbols = <dynamic, String>{};
      for (var val in mapConversion.keys) {
        mapSymbols![val] = null;
      }
    }
    Node conversionTree = Node(name: baseUnit, leafNodes: leafNodes);
    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols!,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  /// Converts a unit with a specific name and value to all other units
  @override
  void convert(var name, double? value) {
    assert(mapConversion.keys.contains(name));
    _customConversion.convert(name, value);
  }

  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);
}
