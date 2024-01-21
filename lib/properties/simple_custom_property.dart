import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';

class SimpleCustomProperty extends DoubleProperty<String> {
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
  final Map<String, double> mapConversion;

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
  ///var customConversion = SimpleCustomProperty(conversionMap, mapSymbols: mapSymbols);
  ///customConversion.convert('EUR', 1);
  ///Unit usd = customConversion.getUnit('USD');
  ///print('1€ = ${usd.stringValue}${usd.symbol}');
  /// ```
  SimpleCustomProperty(this.mapConversion,
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      Map<String, String>? mapSymbols,
      name})
      : assert(mapConversion.containsValue(1),
            'One conversion coefficient must be 1, this will considered the base unit'),
        assert(() {
          if (mapSymbols != null) {
            for (var val in mapConversion.keys) {
              if (!mapSymbols.keys.contains(val)) {
                return false;
              }
            }
          }
          return true;
        }(),
            'mapSymbols should be null or containing all the keys of mapConversion'),
        super(
          name: name ?? 'SimpleCustomProperty',
          mapSymbols: mapSymbols,
          conversionTree: _convertMapToConversionTree(mapConversion),
        );
}

ConversionNode<String> _convertMapToConversionTree(
    Map<String, double> mapConversion) {
  var baseUnit = mapConversion.keys.firstWhere(
      (element) => mapConversion[element] == 1); //take the base unit
  List<ConversionNode<String>> children = [];
  mapConversion.forEach((key, value) {
    if (key != baseUnit) {
      //I'm just interested in the relationship between the base unit and the other units
      children.add(ConversionNode(name: key, coefficientProduct: 1 / value));
    }
  });
  return ConversionNode(name: baseUnit, children: children);
}
