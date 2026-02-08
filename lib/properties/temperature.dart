import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available temperature units
enum TEMPERATURE {
  fahrenheit,
  celsius,
  kelvin,
  reamur,
  romer,
  delisle,
  rankine,
}

class Temperature extends DoubleProperty<TEMPERATURE> {
  ///Class for temperature conversions, e.g. if you want to convert 1 celsius in kelvin:
  ///```dart
  ///var temperature = Temperature(removeTrailingZeros: false);
  ///temperature.convert(TEMPERATURE.celsius, 1);
  ///print(TEMPERATURE.kelvin);
  /// ```
  Temperature(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.temperature,
          mapSymbols: {
            TEMPERATURE.fahrenheit: '°F',
            TEMPERATURE.celsius: '°C',
            TEMPERATURE.kelvin: 'K',
            TEMPERATURE.reamur: '°Re',
            TEMPERATURE.romer: '°Rø',
            TEMPERATURE.delisle: '°De',
            TEMPERATURE.rankine: '°R',
          },
          conversionTree:
              ConversionNode(name: TEMPERATURE.fahrenheit, children: [
            ConversionNode(
                coefficientProduct: 1.8,
                coefficientSum: 32.0,
                name: TEMPERATURE.celsius,
                children: [
                  ConversionNode(
                    coefficientSum: -273.15,
                    name: TEMPERATURE.kelvin,
                  ),
                  ConversionNode(
                    coefficientProduct: 5 / 4,
                    name: TEMPERATURE.reamur,
                  ),
                  ConversionNode(
                    coefficientProduct: 40 / 21,
                    coefficientSum: -100 / 7,
                    name: TEMPERATURE.romer,
                  ),
                  ConversionNode(
                    coefficientProduct: -2 / 3,
                    coefficientSum: 100,
                    name: TEMPERATURE.delisle,
                  ),
                ]),
            ConversionNode(
              coefficientSum: -459.67,
              name: TEMPERATURE.rankine,
            ),
          ]),
        );

  Unit get fahrenheit => getUnit(TEMPERATURE.fahrenheit);
  Unit get celsius => getUnit(TEMPERATURE.celsius);
  Unit get kelvin => getUnit(TEMPERATURE.kelvin);
  Unit get reamur => getUnit(TEMPERATURE.reamur);
  Unit get romer => getUnit(TEMPERATURE.romer);
  Unit get delisle => getUnit(TEMPERATURE.delisle);
  Unit get rankine => getUnit(TEMPERATURE.rankine);
}
