import 'package:units_converter/units_converter.dart';

void main() {
  
  final Map<String, double> conversionMap = {
    'EUR': 1,
    'USD': 1.2271,
    'GBP': 0.9033,
    'JPY': 126.25,
    'CNY': 7.9315,
  };
  // The map of the symbols is optional but nice
  final Map<String, String> mapSymbols = {
    'EUR': '€',
    'USD': '\$',
    'GBP': '₤',
    'JPY': '¥',
    'CNY': '¥',
  };

  var customConversion = SimpleCustomConversion(conversionMap, mapSymbols: mapSymbols);
  customConversion.convert('EUR', 1);
  Unit usd = customConversion.getUnit('USD');
  print('1€ = ${usd.stringValue}${usd.symbol}');
}
