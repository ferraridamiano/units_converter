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

class Pressure {
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
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for pressure conversions, e.g. if you want to convert 1 bar in atmosphere:
  ///```dart
  ///var pressure = Pressure(removeTrailingZeros: false);
  ///pressure.Convert(Unit(PRESSURE.bar, value: 1));
  ///print(PRESSURE.atmosphere);
  /// ```
  Pressure({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    PRESSURE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: PRESSURE.pascal, leafNodes: [
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
  void Convert(PRESSURE name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < PRESSURE.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(PRESSURE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get pascal => _getUnit(PRESSURE.pascal);
  Unit get atmosphere => _getUnit(PRESSURE.atmosphere);
  Unit get bar => _getUnit(PRESSURE.bar);
  Unit get millibar => _getUnit(PRESSURE.millibar);
  Unit get psi => _getUnit(PRESSURE.psi);
  Unit get torr => _getUnit(PRESSURE.torr);

  ///Returns all the pressure units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
