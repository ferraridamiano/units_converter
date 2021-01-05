import 'package:units_converter/UtilsConversion.dart';

//Available TORQUE units
enum TORQUE {
  newton_meter,
  dyne_meter,
  pound_force_feet,
  kilogram_force_meter,
  poundal_meter,
}

class Torque {
  //Map between units and its symbol
  final Map<TORQUE, String> mapSymbols = {
    TORQUE.newton_meter: 'N·m',
    TORQUE.dyne_meter: 'dyn·m',
    TORQUE.pound_force_feet: 'lbf·ft',
    TORQUE.kilogram_force_meter: 'kgf·m',
    TORQUE.poundal_meter: 'pdl·m',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _torque_conversion;

  ///Class for torque conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var torque = Torque(removeTrailingZeros: false);
  ///torque.Convert(Unit(TORQUE.square_meters, value: 1));
  ///print(TORQUE.acres);
  /// ```
  Torque({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    TORQUE.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _torque_conversion = Node(name: TORQUE.newton_meter,
        leafNodes: [
          Node(coefficientProduct: 1e-5, name: TORQUE.dyne_meter,),
          Node(coefficientProduct: 1.35581794902490555 , name: TORQUE.pound_force_feet,),
          Node(coefficientProduct: 9.807, name: TORQUE.kilogram_force_meter,),
          Node(coefficientProduct: 0.138254954376, name: TORQUE.poundal_meter,),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(TORQUE.values.contains(unit.name));
    _torque_conversion.clearAllValues();
    _torque_conversion.clearSelectedNode();
    var currentUnit = _torque_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _torque_conversion.convert();
    for (var i = 0; i < TORQUE.values.length; i++) {
      areaUnitList[i].value = _torque_conversion.getByName(TORQUE.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get newton_meter => _getUnit(TORQUE.newton_meter);
  Unit get dyne_meter => _getUnit(TORQUE.dyne_meter);
  Unit get pound_force_feet => _getUnit(TORQUE.pound_force_feet);
  Unit get kilogram_force_meter => _getUnit(TORQUE.kilogram_force_meter);
  Unit get poundal_meter => _getUnit(TORQUE.poundal_meter);

  ///Returns all the torque units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}