import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

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

class Pressure extends Property<PRESSURE, double> {
  /// Map between units and its symbol
  final Map<PRESSURE, String?> mapSymbols = {
    PRESSURE.pascal: 'Pa',
    PRESSURE.atmosphere: 'atm',
    PRESSURE.bar: 'bar',
    PRESSURE.millibar: 'mbar',
    PRESSURE.psi: 'psi',
    PRESSURE.torr: 'torr', //Same as mmHg
    PRESSURE.hectoPascal: 'hPa',
    PRESSURE.inchOfMercury: 'inHg',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for pressure conversions, e.g. if you want to convert 1 bar in atmosphere:
  ///```dart
  ///var pressure = Pressure(removeTrailingZeros: false);
  ///pressure.convert(Unit(PRESSURE.bar, value: 1));
  ///print(PRESSURE.atmosphere);
  /// ```
  Pressure(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: PRESSURE.pascal, leafNodes: [
      Node(coefficientProduct: 101325.0, name: PRESSURE.atmosphere, leafNodes: [
        Node(coefficientProduct: 0.987, name: PRESSURE.bar, leafNodes: [
          Node(
            coefficientProduct: 1e-3,
            name: PRESSURE.millibar,
          ),
        ]),
      ]),
      Node(
        coefficientProduct: 6894.757293168,
        name: PRESSURE.psi,
      ),
      Node(coefficientProduct: 133.322368421, name: PRESSURE.torr, leafNodes: [
        Node(
          coefficientProduct: 25.4,
          name: PRESSURE.inchOfMercury,
        )
      ]),
      Node(
        coefficientProduct: 1e2,
        name: PRESSURE.hectoPascal,
      )
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. PRESSURE.psi) and value to all other units
  @override
  void convert(PRESSURE name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get pascal => getUnit(PRESSURE.pascal);
  Unit get atmosphere => getUnit(PRESSURE.atmosphere);
  Unit get bar => getUnit(PRESSURE.bar);
  Unit get millibar => getUnit(PRESSURE.millibar);
  Unit get psi => getUnit(PRESSURE.psi);
  Unit get torr => getUnit(PRESSURE.torr);
  Unit get hectoPascal => getUnit(PRESSURE.hectoPascal);
  Unit get inchOfMercury => getUnit(PRESSURE.inchOfMercury);
}
