import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available PRESSURE units
enum PRESSURE {
  pascal,
  atmosphere,
  bar,
  millibar,
  psi,
  torr, //Same as mmHg
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
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for pressure conversions, e.g. if you want to convert 1 bar in atmosphere:
  ///```dart
  ///var pressure = Pressure(removeTrailingZeros: false);
  ///pressure.Convert(Unit(PRESSURE.bar, value: 1));
  ///print(PRESSURE.atmosphere);
  /// ```
  Pressure({this.significantFigures = 10, this.removeTrailingZeros = true}) {
    PRESSURE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: PRESSURE.pascal, leafNodes: [
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
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. PRESSURE.psi) and value to all other units
  @override
  void convert(PRESSURE name, double value) {
    super.convert(name, value);
    for (var i = 0; i < PRESSURE.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(PRESSURE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get pascal => _getUnit(PRESSURE.pascal);
  Unit get atmosphere => _getUnit(PRESSURE.atmosphere);
  Unit get bar => _getUnit(PRESSURE.bar);
  Unit get millibar => _getUnit(PRESSURE.millibar);
  Unit get psi => _getUnit(PRESSURE.psi);
  Unit get torr => _getUnit(PRESSURE.torr);

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
