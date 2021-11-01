# units_converter
[![codecov](https://codecov.io/gh/ferraridamiano/units_converter/branch/main/graph/badge.svg)](https://codecov.io/gh/ferraridamiano/units_converter)
[![Pub](https://img.shields.io/pub/v/units_converter.svg)](https://pub.dev/packages/units_converter)
[![license](https://img.shields.io/github/license/ferraridamiano/units_converter)](https://en.wikipedia.org/wiki/MIT_License)
<a href="https://www.buymeacoffee.com/ferraridamiano">
    <img src="https://shields.io/badge/ferraridamiano-Support--me-FFDD00?logo=buy-me-a-coffee&style=flat&link=https://www.buymeacoffee.com/ferraridamiano"/>
</a>

`units_converter` is a package written in dart for dart & flutter developers. You should not take care of **unit conversion** when you want to **internationalize** your app, everything is already done with this package! You can also add your own **custom conversion**!

This documentation is structured in examples of incresing complexity. But don't worry, in most cases you will only need the first example! 

## Import it

You can use this package in two ways:

1. Add `units_converter` to `pubspec.yaml`:
   
```yaml
# pubspec.yaml
dependencies:
  units_converter: ^1.1.0 # Check out the latest version
```

2. Import the library at the beginning of your `*.dart` file:
   
```dart
import 'package:units_converter/units_converter.dart';
```

## Use it

### Example 1: convert 1 meter in inches

```dart
// We give 1 meter as input
var length = Length()..convert(LENGTH.meters, 1);
// We get the inches
var unit = length.inches;
// We print the Unit
print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
```

Output:

```
name:LENGTH.inches, value:39.370078740157474, stringValue:39.37007874, symbol:in
```

### Example 2: convert 1 degree in all the other angles units. This time we want also to specify that we just want 7 significant figures and we don't want trailing zeros (e.g. 1.000000 -> 1).

```dart
// Initialization of the object
var angle = Angle(significantFigures: 7, removeTrailingZeros: false); // conversion
angle.convert(ANGLE.degree, 1);
// We get all the units
var units = angle.getAll(); //We get all ther others units
// Let's print all of them
for (var unit in units) {
  print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
}
```

Output:

```
name:ANGLE.degree, value:1.0, stringValue:1.000000, symbol:°
name:ANGLE.minutes, value:60.0, stringValue:60.00000, symbol:'
name:ANGLE.seconds, value:3600.0, stringValue:3600.000, symbol:''
```

As you can see in this example if you specify `removeTrailingZeros: false`, the `stringValue` keeps all the trailing zeros (the default is `true`). You can also ask for an certain number of significant figures in the `stringValue`.

### Example 3: convert 100 (decimal) in binary and hexadecimal

*Warning! Numeral systems conversion is the only conversion that need the input as a string, and not as a double/int for obvious reasons*

```dart
// We give '100' decimal as input
var numeralSystems = NumeralSystems()..convert(NUMERAL_SYSTEMS.decimal, '100');
// We get the binary value
print('Binary: ${numeralSystems.binary.stringValue}');
// We get the hexadecimal value
print('Hexadecimal: ${numeralSystems.hexadecimal.stringValue}'); 
```

Output:

```
Binary: 1100100
Hexadecimal: 64
```

### Example 4: simple custom conversion (just give a list of coefficients)

*Use `SimpleCustomConversion` when you are dealing with a linear conversion between the units, i.e. when a unit is `x` times a value. In `SimpleCustomConversion` we have to define a conversionMap between a base unit, which must have a value of 1, and all the other units. In the example below we say that 1€ is 1.2271$, but also 0.9033₤, and so on and so forth.*

```dart
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
```

Output:

```
1€ = 1.2271$
```

### Example 5: custom conversion

*In most cases, you will only need `SimpleCustomConversion` (see example 4). `SimpleCustomConversion` allow you to define conversions in the for of `y=ax`. But if you need to define special relationship between units you need `CustomConversion`. This allow you to perform conversion like: `y=ax+b` and `y=a/x+b` (where `y` and x are the value of two units and `a` and `b` are two coefficient), for example the conversion between Celsius and Fahreneit use the first relation and the conversion between km/l and l/100km has to be done with the second relation. Both can't be done with `SimpleCustomConversion`.*

In the example below I will show you how to define a conversion tree of some imaginary  unit of measurement. Here I define the following relationship:
* `KiloDash` = 1000 * `Dash`
* `Dash+1` = `Dash` + 1
  * `OneOver(OneDash+1)` = 1 / (`Dash+1`)

As you can see all this relations can be structured like a conversion tree. Now you can take a look at the example below: it does in the code what we have just said.

```dart
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
  print('name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
}
```

Output:
```
name:Dash, value:1.0, stringValue:1, symbol:dsh
name:KiloDash, value:0.001, stringValue:0.001, symbol:kdsh
name:Dash+1, value:2.0, stringValue:2, symbol:dsh+1
name:OneOver(OneDash+1), value:0.5, stringValue:0.5, symbol:1/(dsh+1)
```

## Which conversion?

- Angles (degree, radians, etc.)

- Area (hectares, acres, etc.)

- Digital data (byte, gigabit, etc.)

- Energy (Joule, kilowatt-hour, etc.)

- Force (Newton, kilogram-force, etc.)

- Fuel consumption (miles per hour, kilometers per hour, etc.)

- Length (meter, miles, etc)

- Mass (kilograms, ounces, etc.)

- Numeral systems (hexadecimal, binary, etc.)

- Power (kilowatt, horse power, etc.)

- Pressure (bar, psi, etc.)

- Shoe size (eu size, us size, etc.)

- SI prefixes (giga, tera, etc.)

- Speed (miles per hour, kilometers per hour, etc.)

- Temperature (celsius, fahreneit, etc.)

- Time (seconds, years, etc.)

- Torque (newtons per meter, dyne meter)

- Volume (liter, cubic meters, etc.)
