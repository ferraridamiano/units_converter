import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available TEMPERATURE units
enum TEMPERATURE {
  fahrenheit,
  celsius,
  kelvin,
  reamur,
  romer,
  delisle,
  rankine,
}

class Temperature extends Property<TEMPERATURE, double> {
  /// Map between units and its symbol
  static const Map<TEMPERATURE, String?> mapSymbols = {
    TEMPERATURE.fahrenheit: '°F',
    TEMPERATURE.celsius: '°C',
    TEMPERATURE.kelvin: 'K',
    TEMPERATURE.reamur: '°Re',
    TEMPERATURE.romer: '°Rø',
    TEMPERATURE.delisle: '°De',
    TEMPERATURE.rankine: '°R',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  /// Whether to use the scientific notation (true) for [stringValue]s or
  /// decimal notation (false)
  bool useScientificNotation;

  late CustomConversion _customConversion;

  ///Class for temperature conversions, e.g. if you want to convert 1 celsius in kelvin:
  ///```dart
  ///var temperature = Temperature(removeTrailingZeros: false);
  ///temperature.convert(Unit(TEMPERATURE.celsius, value: 1));
  ///print(TEMPERATURE.kelvin);
  /// ```
  Temperature(
      {this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true,
      name}) {
    this.name = name ?? PROPERTY.temperature;
    size = TEMPERATURE.values.length;
    Node conversionTree = Node(name: TEMPERATURE.fahrenheit, leafNodes: [
      Node(
          coefficientProduct: 1.8,
          coefficientSum: 32.0,
          name: TEMPERATURE.celsius,
          leafNodes: [
            Node(
              coefficientSum: -273.15,
              name: TEMPERATURE.kelvin,
            ),
            Node(
              coefficientProduct: 5 / 4,
              name: TEMPERATURE.reamur,
            ),
            Node(
              coefficientProduct: 40 / 21,
              coefficientSum: -100 / 7,
              name: TEMPERATURE.romer,
            ),
            Node(
              coefficientProduct: -2 / 3,
              coefficientSum: 100,
              name: TEMPERATURE.delisle,
            ),
          ]),
      Node(
        coefficientSum: -459.67,
        name: TEMPERATURE.rankine,
      ),
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        useScientificNotation: useScientificNotation);
  }

  ///Converts a unit with a specific name (e.g. TEMPERATURE.kelvin) and value to all other units
  @override
  void convert(TEMPERATURE name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get fahrenheit => getUnit(TEMPERATURE.fahrenheit);
  Unit get celsius => getUnit(TEMPERATURE.celsius);
  Unit get kelvin => getUnit(TEMPERATURE.kelvin);
  Unit get reamur => getUnit(TEMPERATURE.reamur);
  Unit get romer => getUnit(TEMPERATURE.romer);
  Unit get delisle => getUnit(TEMPERATURE.delisle);
  Unit get rankine => getUnit(TEMPERATURE.rankine);
}
