import 'package:units_converter/Length.dart';
import 'package:units_converter/UtilsConversion.dart';

void main() {
  var length = Length(removeTrailingZeros: false);
  length.Convert(Unit(LENGTH.meters, value: 1));
  var units = length.getAll();
  for (var unit in units) {
    print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}\n');
  }
}
