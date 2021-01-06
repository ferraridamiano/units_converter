import 'package:units_converter/UtilsConversion.dart';

//Available SHOE_SIZE units
enum SHOE_SIZE {
  centimeters,
  inches,
  eu_china,
  uk_india_child,
  uk_india_man,
  uk_india_woman,
  usa_canada_child,
  usa_canada_man,
  usa_canada_woman,
  japan,
}

class ShoeSize {
  //Map between units and its symbol
  final Map<SHOE_SIZE, String> mapSymbols = {
    SHOE_SIZE.centimeters: 'cm',
    SHOE_SIZE.inches: 'in',
    SHOE_SIZE.eu_china: null,
    SHOE_SIZE.uk_india_child: null,
    SHOE_SIZE.uk_india_man: null,
    SHOE_SIZE.uk_india_woman: null,
    SHOE_SIZE.usa_canada_child: null,
    SHOE_SIZE.usa_canada_man: null,
    SHOE_SIZE.usa_canada_woman: null,
    SHOE_SIZE.japan: null,
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for ShoeSize conversions, e.g. if you want to convert 1 centimeter in eu shoes size:
  ///```dart
  ///var ShoeSize = ShoeSize(removeTrailingZeros: false);
  ///ShoeSize.Convert(Unit(SHOE_SIZE.centimeters, value: 1));
  ///print(SHOE_SIZE.eu_china);
  /// ```
  ShoeSize({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    SHOE_SIZE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: SHOE_SIZE.centimeters, leafNodes: [
      Node(
        coefficientProduct: 1 / 1.5,
        coefficientSum: -1.5,
        name: SHOE_SIZE.eu_china,
      ),
      Node(coefficientProduct: 2.54, name: SHOE_SIZE.inches, leafNodes: [
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 4,
          name: SHOE_SIZE.uk_india_child,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 8.3333333,
          name: SHOE_SIZE.uk_india_man,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 8.5,
          name: SHOE_SIZE.uk_india_woman,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 3.89,
          name: SHOE_SIZE.usa_canada_child,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 8.0,
          name: SHOE_SIZE.usa_canada_man,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 7.5,
          name: SHOE_SIZE.usa_canada_woman,
        ),
      ]),
      Node(
        coefficientSum: -1.5,
        name: SHOE_SIZE.japan,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(SHOE_SIZE.values.contains(unit.name));
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < SHOE_SIZE.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(SHOE_SIZE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get centimeters => _getUnit(SHOE_SIZE.centimeters);
  Unit get inches => _getUnit(SHOE_SIZE.inches);
  Unit get eu_china => _getUnit(SHOE_SIZE.eu_china);
  Unit get uk_india_child => _getUnit(SHOE_SIZE.uk_india_child);
  Unit get uk_india_man => _getUnit(SHOE_SIZE.uk_india_man);
  Unit get uk_india_woman => _getUnit(SHOE_SIZE.uk_india_woman);
  Unit get usa_canada_child => _getUnit(SHOE_SIZE.usa_canada_child);
  Unit get usa_canada_man => _getUnit(SHOE_SIZE.usa_canada_man);
  Unit get usa_canada_woman => _getUnit(SHOE_SIZE.usa_canada_woman);
  Unit get japan => _getUnit(SHOE_SIZE.japan);

  ///Returns all the ShoeSize units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
