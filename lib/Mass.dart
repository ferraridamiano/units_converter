import 'package:units_converter/UtilsConversion.dart';

//Available MASS units
enum MASS {
  grams,
  ettograms,
  kilograms,
  pounds,
  ounces,
  quintals,
  tons,
  milligrams,
  uma, //unified atomic mass unit
  carats,
  centigrams,
}

class Mass {
  //Map between units and its symbol
  final Map<MASS, String> mapSymbols = {
    MASS.grams: 'g',
    MASS.ettograms: 'hg',
    MASS.kilograms: 'kg',
    MASS.pounds: 'lb',
    MASS.ounces: 'oz',
    MASS.quintals: null,
    MASS.tons: 't',
    MASS.milligrams: 'mg',
    MASS.uma: 'u',
    MASS.carats: 'ct',
    MASS.centigrams: 'cg',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _area_conversion;

  ///Class for mass conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var mass = Mass(removeTrailingZeros: false);
  ///mass.Convert(Unit(MASS.square_meters, value: 1));
  ///print(MASS.acres);
  /// ```
  Mass({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    MASS.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _area_conversion = Node(name: MASS.grams, leafNodes: [
      Node(
        coefficientProduct: 100.0,
        name: MASS.ettograms,
      ),
      Node(coefficientProduct: 1000.0, name: MASS.kilograms, leafNodes: [
        Node(coefficientProduct: 0.45359237, name: MASS.pounds, leafNodes: [
          Node(
            coefficientProduct: 1 / 16,
            name: MASS.ounces,
          )
        ]),
      ]),
      Node(
        coefficientProduct: 100000.0,
        name: MASS.quintals,
      ),
      Node(
        coefficientProduct: 1000000.0,
        name: MASS.tons,
      ),
      Node(
        coefficientProduct: 1e-2,
        name: MASS.centigrams,
      ),
      Node(
        coefficientProduct: 1e-3,
        name: MASS.milligrams,
      ),
      Node(
        coefficientProduct: 1.660539e-24,
        name: MASS.uma,
      ),
      Node(
        coefficientProduct: 0.2,
        name: MASS.carats,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(MASS.values.contains(unit.name));
    _area_conversion.clearAllValues();
    _area_conversion.clearSelectedNode();
    var currentUnit = _area_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _area_conversion.convert();
    for (var i = 0; i < MASS.values.length; i++) {
      areaUnitList[i].value = _area_conversion.getByName(MASS.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get grams => _getUnit(MASS.grams);
  Unit get ettograms => _getUnit(MASS.ettograms);
  Unit get kilograms => _getUnit(MASS.kilograms);
  Unit get pounds => _getUnit(MASS.pounds);
  Unit get ounces => _getUnit(MASS.ounces);
  Unit get quintals => _getUnit(MASS.quintals);
  Unit get tons => _getUnit(MASS.tons);
  Unit get milligrams => _getUnit(MASS.milligrams);
  Unit get uma => _getUnit(MASS.uma);
  Unit get carats => _getUnit(MASS.carats);
  Unit get centigrams => _getUnit(MASS.centigrams);

  ///Returns all the mass units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
