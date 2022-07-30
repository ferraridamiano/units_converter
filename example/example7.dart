import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  // Extends Lenght with a unit called PiMeters which is 3.14149 times 1 meter
  // (the reference unit) and eMeters which is 2.71828 times 1 meter. Optionally
  // we can also add their symbols
  CustomProperty lenght = Length().withCustomUnits(LENGTH.meters, [
    ConversionNode(name: 'PiMeters', coefficientProduct: 3.14159),
    ConversionNode(name: 'eMeters', coefficientProduct: 2.71828),
  ], newSymbols: {
    'PiMeters': 'πm',
    'eMeters': 'em'
  });

  // Let's convert 1 PiMeter to all the other units
  lenght.convert('PiMeters', 1);

  // Let's get the meters and print its value
  var convertedUnit = lenght.getUnit(LENGTH.meters.toString());
  print('1 PiMeter = ${convertedUnit.stringValue} ${convertedUnit.symbol}');
}
