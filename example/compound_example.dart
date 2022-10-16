import 'package:units_converter/units_converter.dart';

void main() {
  // We give 1 meter as input
  var density = Density()..convert(DENSITY.gramsPerLiter, 1);
  // We get the inches
  var unit = density.getUnit(DENSITY.kilogramsPerLiter);
  // We print the Unit
  print(
      'name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
}
