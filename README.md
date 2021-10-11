# units_converter
[![codecov](https://codecov.io/gh/ferraridamiano/units_converter/branch/main/graph/badge.svg)](https://codecov.io/gh/ferraridamiano/units_converter)
[![Pub](https://img.shields.io/pub/v/units_converter.svg)](https://pub.dev/packages/units_converter)
[![license](https://img.shields.io/github/license/ferraridamiano/units_converter)](https://en.wikipedia.org/wiki/MIT_License)

units_converter is a package written in dart for dart & flutter developers. You should not take care of **unit conversion** and **internationalize** your app, everything is already done with this package! Do you need to convert just few units and you don't want to import the whole package, no problem! units_converter is **modular**, you can **import just what you need**! You can also add your own **custom conversion**!

## Usage

### Import it

You can use this package in two ways:

1. Import everything (e.g. you have to develop a unit converter):
   
   ```dart
   import 'package:units_converter/units_converter.dart'; //this will import the whole package
   ```

2. Import just what you need (e.g. you need to internationalize your city distance calculator and you are just interested in length conversion):
   
   ```dart
   import 'package:units_converter/models/unit.dart';
   import 'package:units_converter/properties/length.dart';
   // import 'package:units_converter/properties/area.dart'; ...and every other conversion you need
   ```

### Use it

**Example 1**: convert 1 meter in inches

```dart
var length = Length(removeTrailingZeros: false); //initialize Length object, let's specify that we want to keep the trailing zeros (e.g. 1.00) for stringValue
length.convert(LENGTH.meters, 1); //We give 1 meter as input
var unit = length.inches; //We get all ther others units
print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
```

Output:

```
name:LENGTH.inches, value:39.370078740157474, stringValue:39.37007874, symbol:in
```



**Example 2**: convert 1 degree in all the other angles units

```dart
var angle = Angle(significantFigures: 7, removeTrailingZeros: false); //this time let's also keep 7 significant figures
angle.convert(ANGLE.degree, 1); //We give 1 meter as input
var units = angle.getAll(); //We get all ther others units
for (var unit in units) {
  //Let's print them
  print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
}
```

Output:

```
name:ANGLE.degree, value:1.0, stringValue:1.000000, symbol:°
name:ANGLE.minutes, value:60.0, stringValue:60.00000, symbol:'
name:ANGLE.seconds, value:3600.0, stringValue:3600.000, symbol:''
```

As you can see in this example if you specify `removeTrailingZeros: false`, the `stringValue` keeps all the trailing zeros (the default is `true`). You can also ask for an exact number of significant figures in the `stringValue`.

**Example 3**: convert 100 (decimal) in binary and hexadecimal

```dart
var numeralSystems = NumeralSystems(); //initialize NumeralSystems object
numeralSystems.convert(NUMERAL_SYSTEMS.decimal, '100'); //We give 100 decimal as input
print('Binary: ${numeralSystems.binary.stringValue}'); //We get the binary value
print('Hexadecimal: ${numeralSystems.hexadecimal.stringValue}'); //We get the hexadecimal value
//Warning! Numeral systems conversion is the only conversion that need the input as a string,
//and not as a double/int for obvious reasons
```

Output:

```
Binary: 1100100
Hexadecimal: 64
```

**Example 4**: custom conversion, given a list of coefficient converts units

```dart
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

var customConversion = SimpleCustomConversion(conversionMap, mapSymbols: mapSymbols);
customConversion.convert('EUR', 1);
Unit usd = customConversion.getUnit('USD');
print('1€ = ${usd.stringValue}${usd.symbol}');
```

Output:

```
1€ = 1.2271$
```

## Which conversion?

- Angles (degree, radians, etc.)

- Area (hectares, acres, etc.)

- Digital data (byte, gigabit, etc.)

- Energy (Joule, kilowatt-hour, etc.)

- Force (Newton, kilogram-force, etc.)

- Fuel consumption (miles per hour, kilometers per hour, etc.)

- Length (meter, miles, etc)

- Mass (kilograms, ounces)

- <u>Numeral systems (hexadecimal, binary, etc.)</u>

- Power (kilowatt, horse power, etc.)

- Pressure (bar, psi, etc.)

- Shoe size (eu size, us size, etc.)

- SI prefixes (giga, tera, etc.)

- Speed (miles per hour, kilometers per hour, etc.)

- Temperature (celsius, fahreneit, etc.)

- Time (seconds, years, etc.)

- Torque (newtons per meter, dyne meter)

- Volume (liter, cubic meters, etc.)