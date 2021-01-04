import 'package:units_converter/UtilsConversion.dart';

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
  List<Unit> areaUnitList = [];
  Node _temperature_conversion;

  ///Class for temperature conversions, e.g. if you want to convert 1 celsius in kelvin:
  ///```dart
  ///var temperature = Temperature(removeTrailingZeros: false);
  ///temperature.Convert(Unit(TEMPERATURE.celsius, value: 1));
  ///print(TEMPERATURE.kelvin);
  /// ```
  Temperature({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    TEMPERATURE.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _temperature_conversion = Node(name: TEMPERATURE.fahrenheit, leafNodes: [
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

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(TEMPERATURE.values.contains(unit.name));
    _temperature_conversion.clearAllValues();
    _temperature_conversion.clearSelectedNode();
    var currentUnit = _temperature_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _temperature_conversion.convert();
    for (var i = 0; i < TEMPERATURE.values.length; i++) {
      areaUnitList[i].value = _temperature_conversion.getByName(TEMPERATURE.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
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
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
