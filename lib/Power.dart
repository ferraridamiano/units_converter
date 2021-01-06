import 'UtilsConversion.dart';
import 'Unit.dart';

//Available POWER units
enum POWER {
  watt,
  milliwatt,
  kilowatt,
  megawatt,
  gigawatt,
  european_horse_power,
  imperial_horse_power,
}

class Power {
  //Map between units and its symbol
  final Map<POWER, String> mapSymbols = {
    POWER.watt: 'W',
    POWER.milliwatt: 'mW',
    POWER.kilowatt: 'kW',
    POWER.megawatt: 'MW',
    POWER.gigawatt: 'GW',
    POWER.european_horse_power: 'hp(M)',
    POWER.imperial_horse_power: 'hp(I)',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _power_conversion;

  ///Class for power conversions, e.g. if you want to convert 1 kilowatt in european horse power:
  ///```dart
  ///var power = Power(removeTrailingZeros: false);
  ///power.Convert(Unit(POWER.kilowatt, value: 1));
  ///print(POWER.european_horse_power);
  /// ```
  Power({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    POWER.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _power_conversion = Node(name: POWER.watt, leafNodes: [
      Node(
        coefficientProduct: 1e-3,
        name: POWER.milliwatt,
      ),
      Node(
        coefficientProduct: 1e3,
        name: POWER.kilowatt,
      ),
      Node(
        coefficientProduct: 1e6,
        name: POWER.megawatt,
      ),
      Node(
        coefficientProduct: 1e9,
        name: POWER.gigawatt,
      ),
      Node(
        coefficientProduct: 735.49875,
        name: POWER.european_horse_power,
      ),
      Node(
        coefficientProduct: 745.69987158,
        name: POWER.imperial_horse_power,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(POWER.values.contains(unit.name));
    _power_conversion.clearAllValues();
    _power_conversion.clearSelectedNode();
    var currentUnit = _power_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _power_conversion.convert();
    for (var i = 0; i < POWER.values.length; i++) {
      areaUnitList[i].value = _power_conversion.getByName(POWER.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get watt => _getUnit(POWER.watt);
  Unit get milliwatt => _getUnit(POWER.milliwatt);
  Unit get kilowatt => _getUnit(POWER.kilowatt);
  Unit get megawatt => _getUnit(POWER.megawatt);
  Unit get gigawatt => _getUnit(POWER.gigawatt);
  Unit get european_horse_power => _getUnit(POWER.european_horse_power);
  Unit get imperial_horse_power => _getUnit(POWER.imperial_horse_power);

  ///Returns all the power units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
