# units_converter
[![codecov](https://codecov.io/gh/ferraridamiano/units_converter/branch/main/graph/badge.svg)](https://codecov.io/gh/ferraridamiano/units_converter)
[![Pub](https://img.shields.io/pub/v/units_converter.svg?style=flat-square&logo=dart)](https://pub.dev/packages/units_converter)
[![license](https://img.shields.io/github/license/ferraridamiano/units_converter?style=flat-square)](https://en.wikipedia.org/wiki/MIT_License)
[<img src="https://img.shields.io/static/v1?style=for-the-badge&message=PayPal&color=00457C&logo=PayPal&logoColor=FFFFFF&label="
    alt="Donate with Paypal" height=21>](https://www.paypal.me/DemApps)

`units_converter` is a package written in dart for dart & flutter developers. You should not take care of **unit conversion** when you want to **internationalize** your app, everything is already done with this package! You can also add your own **custom conversion**!

This package is used by [Converter NOW](https://github.com/ferraridamiano/ConverterNOW)!

The documentation is structured in examples of increasing complexity. But don't worry, in most cases you will only need the first examples.

## Table of Contents
- [Convert a unit to another unit (the easy way)](#convert-a-unit-to-another-unit-the-easy-way)
- [Convert a unit to another unit](#convert-a-unit-to-another-unit)
- [Convert a unit to all the another units](#convert-a-unit-to-all-the-another-units)
- [Special type of conversion: numeral systems conversion](#special-type-of-conversion-numeral-systems-conversion)
- [Simple custom conversion](#simple-custom-conversion)
- [Custom conversion](#custom-conversion)
- [Which conversions?](#which-conversions)

## Convert a unit to another unit (the easy way)
**Example 1**: convert 1 meter in inches

```dart
// Convert 1 meter in inches
var inches = 1.convertFromTo(LENGTH.meters, LENGTH.inches);
// Print it
print(inches);
```

Output:

```
39.37007874015748
```

What about numeral systems? Same thing but with `String`:

```dart
// Convert '8B' hexadecimal to octal
var octal = '8B'.convertFromTo(NUMERAL_SYSTEMS.hexadecimal, NUMERAL_SYSTEMS.octal);
// Print it
print(octal);
```

Output:

```
213
```

**Note**: most of the time is what you need, use this method if you just want to convert a unit in another unit. BUT, it is not recommended if you want to convert a unit to multiple units, or if you are interested in the symbol of a unit or if you are interested in the format of the string representation of the value (significant figures, scientific notation, etc.).

## Convert a unit to another unit
**Example 2**: convert 1 meter in inches

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

## Convert a unit to all the another units
**Example 3**: convert 1 degree in all the other angles units. This time we want also to specify that we just want 7 significant figures and we don't want trailing zeros (e.g. 1.000000 -> 1).

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

## Special type of conversion: numeral systems conversion
*Warning! Numeral systems conversion is the only conversion that need the input as a `String`, and not as a `double` / `int` for obvious reasons*

**Example 4**: convert '`100`' (decimal) to binary and hexadecimal

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

## Simple custom conversion
*Use `SimpleCustomProperty` when you are dealing with a linear conversion between the units, i.e. when a unit is `x` times a value. In `SimpleCustomProperty` we have to define a conversionMap between a base unit, which must have a value of 1, and all the other units. In the example below we say that 1€ is 1.2271$, but also 0.9033₤, and so on and so forth.*

**Example 5**: define the currency exchange rate with their symbols (optional) and perform the conversion between two of them.

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

var customConversion = SimpleCustomProperty(conversionMap, mapSymbols: mapSymbols);
customConversion.convert('EUR', 1);
Unit usd = customConversion.getUnit('USD');
print('1€ = ${usd.stringValue}${usd.symbol}');
```

Output:

```
1€ = 1.2271$
```

## Custom conversion

*In most cases, you will only need `SimpleCustomProperty` (see the previous section). `SimpleCustomProperty` allow you to define conversions in the form of `y=ax`. But if you need to define special relationship between units you need `CustomProperty`. This allow you to perform conversion like: `y=ax+b` and `y=a/x+b` (where `y` and x are the value of two units and `a` and `b` are two coefficient), for example the conversion between Celsius and Fahrenheit use the first relation and the conversion between km/l and l/100km has to be done with the second relation. Both can't be done with `SimpleCustomProperty`.*

**Example 6**: let's define the following imaginary units of measurement:

* `KiloDash` = 1000 * `Dash`
* `DashPlus1` = `Dash` + 1
  * `OneOver(DashPlus1)` = 1 / (`DashPlus1`)

As you can see all this relations can be structured like a conversion tree. Now you can take a look at the example below: it does in the code what we have just said.

```dart
ConversionNode conversionTree = ConversionNode(
  name: 'Dash',
  children: [
    ConversionNode(
      name: 'KiloDash',
      coefficientProduct: 1000,
    ),
    ConversionNode(
      name: 'DashPlus1',
      coefficientSum: -1,
      children: [
        ConversionNode(
          name: 'OneOver(DashPlus1)',
          conversionType: ConversionType.reciprocalConversion,
        ),
      ],
    ),
  ],
);
final Map<String, String> symbolsMap = {
  'Dash': 'dsh',
  'KiloDash': 'kdsh',
};
var dash = CustomProperty(
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
name:DashPlus1, value:2.0, stringValue:2, symbol:null
name:OneOver(DashPlus1), value:0.5, stringValue:0.5, symbol:null
```

## Which conversions?

- Amount of substance (moles, millimoles, etc.)
- Angles (degree, radians, etc.)
- Area (hectares, acres, etc.)
- Digital data (byte, gigabit, etc.)
- Density (grams per liter, micrograms per milliliter, etc.)
- Energy (Joule, kilowatt-hour, etc.)
- Force (Newton, kilogram-force, etc.)
- Fuel consumption (miles per hour, kilometers per hour, etc.)
- Length (meter, miles, etc)
- Mass (kilograms, ounces, etc.)
- Molar mass (grams per mole, milligrams per millimole, etc.)
- Molar mass (moles per cubic meter, moles per liter, etc.)
- Numeral systems (hexadecimal, binary, etc.)
- Power (kilowatt, horse power, etc.)
- Pressure (bar, psi, etc.)
- Reciprocal of molar mass (moles per gram, etc.)
- Shoe size (eu size, us size, etc.)
- SI prefixes (giga, tera, etc.)
- Speed (miles per hour, kilometers per hour, etc.)
- Temperature (celsius, fahrenheit, etc.)
- Time (seconds, years, etc.)
- Torque (newtons per meter, dyne meter, etc.)
- Volume (liter, cubic meters, etc.)
