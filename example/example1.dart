import 'package:units_converter/units_converter.dart';

void main() {
  // We give 1 meter as input
  var length = Length()..convert(LENGTH.meters, 1);
  // We get the inches
  var unit = length.inches;
  // We print the Unit
  print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
}