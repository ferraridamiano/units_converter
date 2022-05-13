import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/custom_conversion.dart';

class SimpleCustomConversion extends CustomConversion {
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
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      mapSymbols,
      name})
      : assert(mapConversion.containsValue(1),
            'One conversion coefficient must be 1, this will considered the base unit'),
        assert(() {
          if (mapSymbols != null) {
            for (var val in mapConversion.keys) {
              if (!mapSymbols!.keys.contains(val)) {
                return false;
              }
            }
          }
          return true;
        }(), 'The key of mapConversion must be the same key of mapSymbols'),
        super(
          name: name ?? 'SimpleCustomConversion',
          mapSymbols: mapSymbols ?? _initializeMapSymbols(mapConversion),
          conversionTree: _convertMapToConversionTree(mapConversion),
        );
}

Node _convertMapToConversionTree(Map<dynamic, double> mapConversion) {
  var baseUnit = mapConversion.keys.firstWhere(
      (element) => mapConversion[element] == 1); //take the base unit
  List<Node> leafNodes = [];
  mapConversion.forEach((key, value) {
    if (key != baseUnit) {
      //I'm just interested in the relationship between the base unit and the other units
      leafNodes.add(Node(name: key, coefficientProduct: 1 / value));
    }
  });
  return Node(name: baseUnit, leafNodes: leafNodes);
}

Map<dynamic, String?> _initializeMapSymbols(
    Map<dynamic, double> mapConversion) {
  var mapSymbols = <dynamic, String?>{};
  for (var val in mapConversion.keys) {
    mapSymbols[val] = null;
  }
  return mapSymbols;
}
