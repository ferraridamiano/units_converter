import 'UtilsConversion.dart';
import 'Unit.dart';

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

class Temperature {
  //Map between units and its symbol
  final Map<TEMPERATURE, String> mapSymbols = {
    TEMPERATURE.fahrenheit: '°F',
    TEMPERATURE.celsius: '°C',
    TEMPERATURE.kelvin: 'K',
    TEMPERATURE.reamur: '°Re',
    TEMPERATURE.romer: '°Rø',
    TEMPERATURE.delisle: '°De',
    TEMPERATURE.rankine: '°R',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for temperature conversions, e.g. if you want to convert 1 celsius in kelvin:
  ///```dart
  ///var temperature = Temperature(removeTrailingZeros: false);
  ///temperature.Convert(Unit(TEMPERATURE.celsius, value: 1));
  ///print(TEMPERATURE.kelvin);
  /// ```
  Temperature({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    TEMPERATURE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: TEMPERATURE.fahrenheit, leafNodes: [
      Node(coefficientProduct: 1.8, coefficientSum: 32.0, name: TEMPERATURE.celsius, leafNodes: [
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
  }

  ///Converts a unit with a specific name (e.g. TEMPERATURE.kelvin) and value to all other units
  void Convert(TEMPERATURE name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < TEMPERATURE.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(TEMPERATURE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get fahrenheit => _getUnit(TEMPERATURE.fahrenheit);
  Unit get celsius => _getUnit(TEMPERATURE.celsius);
  Unit get kelvin => _getUnit(TEMPERATURE.kelvin);
  Unit get reamur => _getUnit(TEMPERATURE.reamur);
  Unit get romer => _getUnit(TEMPERATURE.romer);
  Unit get delisle => _getUnit(TEMPERATURE.delisle);
  Unit get rankine => _getUnit(TEMPERATURE.rankine);

  ///Returns all the temperature units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
