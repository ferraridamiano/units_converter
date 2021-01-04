import 'package:units_converter/UtilsConversion.dart';

//Available SPEED units
enum SPEED {
  meters_per_second,
  kilometers_per_hour,
  miles_per_hour,
  knots,
  feets_per_second,
}

class Speed {
  //Map between units and its symbol
  final Map<SPEED, String> mapSymbols = {
    SPEED.meters_per_second: 'm/s',
    SPEED.kilometers_per_hour: 'km/h',
    SPEED.miles_per_hour: 'mi/h',
    SPEED.knots: 'kts',
    SPEED.feets_per_second: 'ft/s',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _speed_conversion;

  ///Class for speed conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var speed = Speed(removeTrailingZeros: false);
  ///speed.Convert(Unit(SPEED.square_meters, value: 1));
  ///print(SPEED.acres);
  /// ```
  Speed({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    SPEED.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _speed_conversion = Node(name: SPEED.meters_per_second, leafNodes: [
      Node(coefficientProduct: 1 / 3.6, name: SPEED.kilometers_per_hour, leafNodes: [
        Node(
          coefficientProduct: 1.609344,
          name: SPEED.miles_per_hour,
        ),
        Node(
          coefficientProduct: 1.852,
          name: SPEED.knots,
        ),
      ]),
      Node(
        coefficientProduct: 0.3048,
        name: SPEED.feets_per_second,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(SPEED.values.contains(unit.name));
    _speed_conversion.clearAllValues();
    _speed_conversion.clearSelectedNode();
    var currentUnit = _speed_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _speed_conversion.convert();
    for (var i = 0; i < SPEED.values.length; i++) {
      areaUnitList[i].value = _speed_conversion.getByName(SPEED.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get meters_per_second => _getUnit(SPEED.meters_per_second);
  Unit get kilometers_per_hour => _getUnit(SPEED.kilometers_per_hour);
  Unit get miles_per_hour => _getUnit(SPEED.miles_per_hour);
  Unit get knots => _getUnit(SPEED.knots);
  Unit get feets_per_second => _getUnit(SPEED.feets_per_second);

  ///Returns all the speed units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
