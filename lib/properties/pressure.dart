import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available PRESSURE units
enum PRESSURE {
  pascal,
  atmosphere,
  bar,
  millibar,
  psi,
  torr, //Same as mmHg
  hectoPascal,
  inchOfMercury,
}

class Pressure extends CustomProperty {
  ///Class for pressure conversions, e.g. if you want to convert 1 bar in atmosphere:
  ///```dart
  ///var pressure = Pressure(removeTrailingZeros: false);
  ///pressure.convert(Unit(PRESSURE.bar, value: 1));
  ///print(PRESSURE.atmosphere);
  /// ```
  Pressure(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.pressure,
          mapSymbols: {
            PRESSURE.pascal: 'Pa',
            PRESSURE.atmosphere: 'atm',
            PRESSURE.bar: 'bar',
            PRESSURE.millibar: 'mbar',
            PRESSURE.psi: 'psi',
            PRESSURE.torr: 'torr', //Same as mmHg
            PRESSURE.hectoPascal: 'hPa',
            PRESSURE.inchOfMercury: 'inHg',
          },
          conversionTree: ConversionNode(name: PRESSURE.pascal, leafNodes: [
            ConversionNode(
                coefficientProduct: Rational.fromInt(100000),
                name: PRESSURE.bar,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: Rational.parse('1e-3'),
                    name: PRESSURE.millibar,
                  ),
                ]),
            ConversionNode(
              coefficientProduct: Rational.fromInt(101325),
              name: PRESSURE.atmosphere,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('6894.757293168'),
              name: PRESSURE.psi,
            ),
            ConversionNode(
                coefficientProduct: Rational.parse('133.322368421'),
                name: PRESSURE.torr,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: Rational.parse('25.4'),
                    name: PRESSURE.inchOfMercury,
                  )
                ]),
            ConversionNode(
              coefficientProduct: Rational.fromInt(100),
              name: PRESSURE.hectoPascal,
            )
          ]),
        );

  Unit get pascal => getUnit(PRESSURE.pascal);
  Unit get atmosphere => getUnit(PRESSURE.atmosphere);
  Unit get bar => getUnit(PRESSURE.bar);
  Unit get millibar => getUnit(PRESSURE.millibar);
  Unit get psi => getUnit(PRESSURE.psi);
  Unit get torr => getUnit(PRESSURE.torr);
  Unit get hectoPascal => getUnit(PRESSURE.hectoPascal);
  Unit get inchOfMercury => getUnit(PRESSURE.inchOfMercury);
}
