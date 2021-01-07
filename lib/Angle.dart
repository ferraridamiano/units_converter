import 'UtilsConversion.dart';
import 'Unit.dart';

//Available ANGLE units
enum ANGLE {
  degree,
  minutes,
  seconds,
  radians,
}

class Angle {
  //Map between units and its symbol
  final Map<ANGLE, String> mapSymbols = {
    ANGLE.degree: '°',
    ANGLE.minutes: "'",
    ANGLE.seconds: "''",
    ANGLE.radians: 'rad',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for angle conversions, e.g. if you want to convert 1 radiant in degree:
  ///```dart
  ///var angle = Angle(removeTrailingZeros: false);
  ///angle.Convert(Unit(ANGLE.radians, value: 1));
  ///print(ANGLE.degree);
  /// ```
  Angle({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    ANGLE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: ANGLE.degree, leafNodes: [
      Node(
        coefficientProduct: 1 / 60,
        name: ANGLE.minutes,
      ),
      Node(
        coefficientProduct: 1 / 3600,
        name: ANGLE.seconds,
      ),
      Node(
        coefficientProduct: 57.295779513,
        name: ANGLE.radians,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. ANGLE.degree) and value to all other units
  void Convert(ANGLE name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < ANGLE.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(ANGLE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get degree => _getUnit(ANGLE.degree);
  Unit get minutes => _getUnit(ANGLE.minutes);
  Unit get seconds => _getUnit(ANGLE.seconds);
  Unit get radians => _getUnit(ANGLE.radians);

  ///Returns all the angle units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
