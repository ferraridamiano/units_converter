import 'package:units_converter/units_converter.dart';

void main() {
  // We give '100' decimal as input
  var numeralSystems = NumeralSystems()
    ..convert(NUMERAL_SYSTEMS.decimal, '100');
  // We get the binary value
  print('Binary: ${numeralSystems.binary.stringValue}');
  // We get the hexadecimal value
  print('Hexadecimal: ${numeralSystems.hexadecimal.stringValue}');
}
