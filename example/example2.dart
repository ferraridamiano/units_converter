import 'package:units_converter/units_converter.dart';

void main() {
  // Initialization of the object
  var angle = Angle(significantFigures: 7, removeTrailingZeros: false); // conversion
  angle.convert(ANGLE.degree, 1);
  // We get all the units
  var units = angle.getAll(); //We get all ther others units
  // Let's print all of them
  for (var unit in units) {
    print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
  }
}
