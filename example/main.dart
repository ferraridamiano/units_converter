import 'package:units_converter/models/node.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  //example 1: convert 1 meter in inches
  var length = Length()..convert(LENGTH.meters, 1); //We give 1 meter as input
  var unit = length.inches; //We get all ther others units
  print(
      'name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');

  //------------------------------------------------------------------------------------------------------------------------------------------------------------

  //example 2: convert 1 degree in all ther other angle units
  var angle = Angle(
      significantFigures: 7,
      removeTrailingZeros:
          false); //this time let's also keep 7 significant figures
  angle.convert(ANGLE.degree, 1); //We give 1 meter as input
  var units = angle.getAll(); //We get all ther others units
  for (var unit in units) {
    //Let's print them
    print(
        'name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
  }

  //------------------------------------------------------------------------------------------------------------------------------------------------------------

  //example 3: convert 100 (decimal) in binary and hexadecimal
  var numeralSystems = NumeralSystems(); //initialize NumeralSystems object
  numeralSystems.convert(
      NUMERAL_SYSTEMS.decimal, '100'); //We give 100 decimal as input
  print(
      'Binary: ${numeralSystems.binary.stringValue}'); //We get the binary value
  print(
      'Hexadecimal: ${numeralSystems.hexadecimal.stringValue}'); //We get the hexadecimal value
  //Warning! Numeral systems conversion is the only conversion that need the input as a string, and not as a double/int for obvous reasons

  //------------------------------------------------------------------------------------------------------------------------------------------------------------

  //example 4: given a list of coefficient converts units
  //Define the relation between a units and the others. One of the units MUST have a value of 1
  //(it will be considered the base unit from where to start the conversion)
  final Map<String, double> conversionMap = {
    'EUR': 1,
    'USD': 1.2271,
    'GBP': 0.9033,
    'JPY': 126.25,
    'CNY': 7.9315,
  };
  //Optional
  final Map<String, String> mapSymbols = {
    'EUR': '€',
    'USD': '\$',
    'GBP': '₤',
    'JPY': '¥',
    'CNY': '¥',
  };

  var customConversion =
      SimpleCustomConversion(conversionMap, mapSymbols: mapSymbols);
  customConversion.convert('EUR', 1);
  Unit usd = customConversion.getUnit('USD');
  print('1€ = ${usd.stringValue}${usd.symbol}');

  //----------------------------------------------------------------------------

  //Example 5:
  Node conversionTree = Node(
    name: 'Dash',
    leafNodes: [
      Node(
        name: 'KiloDash',
        coefficientProduct: 1000,
      ),
      Node(
        name: 'Dash+1',
        coefficientSum: -1,
        leafNodes: [
          Node(
            name: 'OneOver(OneDash+1)',
            conversionType: CONVERSION_TYPE.reciprocalConversion,
          ),
        ],
      ),
    ],
  );

  final Map<String, String> symbolsMap = {
    'Dash': 'dsh',
    'KiloDash': 'kdsh',
    'Dash+1': 'dsh+1',
    'OneOver(OneDash+1)': '1/(dsh+1)',
  };
  var dash = CustomConversion(
    conversionTree: conversionTree,
    mapSymbols: symbolsMap,
    name: 'Conversion of Dash',
  );

  dash.convert('Dash', 1);

  var myUnits = dash.getAll();
  for (var unit in myUnits) {
    print(
        'name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
  }

  print(angle.getUnit(ANGLE.radians).value);
}
