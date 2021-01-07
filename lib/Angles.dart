import 'UtilsConversion.dart';
import 'Unit.dart';

//Available ANGLES units
enum ANGLES {
  degree,
  minutes,
  seconds,
  radians,
}

class Angles {
  //Map between units and its symbol
  final Map<ANGLES, String> mapSymbols = {
    ANGLES.degree: '°',
    ANGLES.minutes: "'",
    ANGLES.seconds: "''",
    ANGLES.radians: 'rad',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for angles conversions, e.g. if you want to convert 1 radiant in degree:
  ///```dart
  ///var angles = Angles(removeTrailingZeros: false);
  ///angles.Convert(Unit(ANGLES.radians, value: 1));
  ///print(ANGLES.degree);
  /// ```
  Angles({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    ANGLES.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: ANGLES.degree, leafNodes: [
      Node(
        coefficientProduct: 1 / 60,
        name: ANGLES.minutes,
      ),
      Node(
        coefficientProduct: 1 / 3600,
        name: ANGLES.seconds,
      ),
      Node(
        coefficientProduct: 57.295779513,
        name: ANGLES.radians,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. ANGLES.degree) and value to all other units
  void Convert(ANGLES name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < ANGLES.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(ANGLES.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get degree => _getUnit(ANGLES.degree);
  Unit get minutes => _getUnit(ANGLES.minutes);
  Unit get seconds => _getUnit(ANGLES.seconds);
  Unit get radians => _getUnit(ANGLES.radians);

  ///Returns all the angles units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
