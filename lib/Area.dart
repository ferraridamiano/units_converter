import 'package:units_converter/UtilsConversion.dart';

//Available AREA units
enum AREA {
  square_meters,
  square_centimeters,
  square_inches,
  square_feet,
  square_miles,
  square_yard,
  square_millimeters,
  square_kilometers,
  hectares,
  acres,
  are,
}

class Area {
  //Map between units and its symbol
  final Map<AREA, String> mapSymbols = {
    AREA.square_meters: 'm²',
    AREA.square_centimeters: 'cm²',
    AREA.square_inches: 'in²',
    AREA.square_feet: 'ft²',
    AREA.square_miles: 'mi²',
    AREA.square_yard: 'yd²',
    AREA.square_millimeters: 'mm²',
    AREA.square_kilometers: 'km²',
    AREA.hectares: 'he',
    AREA.acres: 'ac',
    AREA.are: 'a',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _area_conversion;

  ///Class for area conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var area = Area(removeTrailingZeros: false);
  ///area.Convert(Unit(AREA.square_meters, value: 1));
  ///print(AREA.acres);
  /// ```
  Area({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    AREA.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _area_conversion = Node(name: AREA.square_meters, leafNodes: [
      Node(coefficientProduct: 1e-4, name: AREA.square_centimeters, leafNodes: [
        Node(coefficientProduct: 6.4516, name: AREA.square_inches, leafNodes: [
          Node(
            coefficientProduct: 144.0,
            name: AREA.square_feet,
          ),
        ]),
      ]),
      Node(
        coefficientProduct: 1e-6,
        name: AREA.square_millimeters,
      ),
      Node(
        coefficientProduct: 10000.0,
        name: AREA.hectares,
      ),
      Node(
        coefficientProduct: 1000000.0,
        name: AREA.square_kilometers,
      ),
      Node(coefficientProduct: 0.83612736, name: AREA.square_yard, leafNodes: [
        Node(
          coefficientProduct: 3097600.0,
          name: AREA.square_miles,
        ),
        Node(
          coefficientProduct: 4840.0,
          name: AREA.acres,
        ),
      ]),
      Node(
        coefficientProduct: 100.0,
        name: AREA.are,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(AREA.values.contains(unit.name));
    _area_conversion.clearAllValues();
    _area_conversion.clearSelectedNode();
    var currentUnit = _area_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _area_conversion.convert();
    for (var i = 0; i < AREA.values.length; i++) {
      areaUnitList[i].value = _area_conversion.getByName(AREA.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get square_meters => _getUnit(AREA.square_meters);
  Unit get square_centimeters => _getUnit(AREA.square_centimeters);
  Unit get square_inches => _getUnit(AREA.square_inches);
  Unit get square_feet => _getUnit(AREA.square_feet);
  Unit get square_miles => _getUnit(AREA.square_miles);
  Unit get square_yard => _getUnit(AREA.square_yard);
  Unit get square_millimeters => _getUnit(AREA.square_millimeters);
  Unit get square_kilometers => _getUnit(AREA.square_kilometers);
  Unit get hectares => _getUnit(AREA.hectares);
  Unit get acres => _getUnit(AREA.acres);
  Unit get are => _getUnit(AREA.are);

  ///Returns all the area units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
