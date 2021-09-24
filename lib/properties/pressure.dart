import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils_conversion.dart';

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
  //Map between units and its symbol
  final Map<PRESSURE, String> mapSymbols = {
    PRESSURE.pascal: 'Pa',
    PRESSURE.atmosphere: 'atm',
    PRESSURE.bar: 'bar',
    PRESSURE.millibar: 'mbar',
    PRESSURE.psi: 'psi',
    PRESSURE.torr: 'torr', //Same as mmHg
    PRESSURE.hectoPascal: 'hPa',
    PRESSURE.inchOfMercury: 'inHg',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for pressure conversions, e.g. if you want to convert 1 bar in atmosphere:
  ///```dart
  ///var pressure = Pressure(removeTrailingZeros: false);
  ///pressure.convert(Unit(PRESSURE.bar, value: 1));
  ///print(PRESSURE.atmosphere);
  /// ```
  Pressure({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = PRESSURE.values.length;
    this.name = name ?? PROPERTY.pressure;
    for (PRESSURE val in PRESSURE.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: PRESSURE.pascal, leafNodes: [
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
      Node(
        coefficientProduct: 133.322368421,
        name: PRESSURE.torr,
        leafNodes: [
          Node(
            coefficientProduct: 25.4,
            name: PRESSURE.inchOfMercury,
          )
        ]
      ),
      Node(
        coefficientProduct: 1e-2,
        name: PRESSURE.hectoPascal,
      )
    ]);
  }

  ///Converts a unit with a specific name (e.g. PRESSURE.psi) and value to all other units
  @override
  void convert(PRESSURE name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < PRESSURE.values.length; i++) {
      unitList[i].value = unitConversion.getByName(PRESSURE.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get pascal => getUnit(PRESSURE.pascal);
  Unit get atmosphere => getUnit(PRESSURE.atmosphere);
  Unit get bar => getUnit(PRESSURE.bar);
  Unit get millibar => getUnit(PRESSURE.millibar);
  Unit get psi => getUnit(PRESSURE.psi);
  Unit get torr => getUnit(PRESSURE.torr);
  Unit get hectoPascal => getUnit(PRESSURE.hectoPascal);
  Unit get inchOfMercury => getUnit(PRESSURE.inchOfMercury);
}
