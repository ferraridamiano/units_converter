import 'UtilsConversion.dart';
import 'Unit.dart';

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
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for mass conversions, e.g. if you want to convert 1 gram in ounces:
  ///```dart
  ///var mass = Mass(removeTrailingZeros: false);
  ///mass.Convert(Unit(MASS.grams, value: 1));
  ///print(MASS.ounces);
  /// ```
  Mass({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    MASS.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: MASS.grams, leafNodes: [
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

  ///Converts a unit with a specific name (e.g. MASS.centigrams) and value to all other units
  void Convert(MASS name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < MASS.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(MASS.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
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
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
