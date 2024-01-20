import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

//Available PRESSURE units
enum PRESSURE {
  pascal,
  atmosphere,
  bar,
  millibar,
  psi,
  torr, //Same as mmHg
  hectoPascal,
  kiloPascal,
  inchOfMercury,
}

class Pressure extends DoubleProperty<PRESSURE> {
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
          conversionTree: ConversionNode(name: PRESSURE.pascal, children: [
            ConversionNode(
                coefficientProduct: 1e5,
                name: PRESSURE.bar,
                children: [
                  ConversionNode(
                    coefficientProduct: 1e-3,
                    name: PRESSURE.millibar,
                  ),
                ]),
            ConversionNode(
              coefficientProduct: 101325.0,
              name: PRESSURE.atmosphere,
            ),
            ConversionNode(
              coefficientProduct: 6894.757293168,
              name: PRESSURE.psi,
            ),
            ConversionNode(
                coefficientProduct: 133.322368421,
                name: PRESSURE.torr,
                children: [
                  ConversionNode(
                    coefficientProduct: 25.4,
                    name: PRESSURE.inchOfMercury,
                  )
                ]),
            ConversionNode(
              coefficientProduct: 1e2,
              name: PRESSURE.hectoPascal,
            ),
            ConversionNode(
              coefficientProduct: 1e3,
              name: PRESSURE.kiloPascal,
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
  Unit get kiloPascal => getUnit(PRESSURE.kiloPascal);
  Unit get inchOfMercury => getUnit(PRESSURE.inchOfMercury);
}
