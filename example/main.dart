import 'package:units_converter/units_converter.dart';

void main() {
  //example 1: convert 1 meter in all ther other length units
  var length = Length(removeTrailingZeros: false); //initialize Length object, let's specify that we want to keep the trailing zeros (e.g. 1.000) for stringValue
  length.Convert(Unit(LENGTH.meters, value: 1));   //We give 1 meter as input
  var units = length.getAll();                     //We get all ther others units
  for (var unit in units) {
    //Let's print them
    print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}\n');
  }

  //example 2: convert 100 (decimal) in binary and hexadecimal
  var numeralSystems = NumeralSystems();                                      //initialize NumeralSystems object
  numeralSystems.Convert(Unit(NUMERAL_SYSTEMS.decimal, stringValue: '100'));  //We give 100 decimal as input
  print('Binary: ${numeralSystems.binary.stringValue}');                      //We get the binary value
  print('Hexadecimal: ${numeralSystems.hexadecimal.stringValue}');            //We get the hexadecimal value
  
  //Warning! Numeral systems conversion is the only conversion that need the input as a string, and not as a double/int for obvous reasons
}
