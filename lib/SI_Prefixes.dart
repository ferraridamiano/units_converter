import 'package:units_converter/UtilsConversion.dart';

//Available SI_PREFIXES units
enum SI_PREFIXES {
  base,
  deca,
  hecto,
  kilo,
  mega,
  giga,
  tera,
  peta,
  exa,
  zetta,
  yotta,
  deci,
  centi,
  milli,
  micro,
  nano,
  pico,
  femto,
  atto,
  zepto,
  yocto,
}

class Si_Prefixes {
  //Map between units and its symbol
  final Map<SI_PREFIXES, String> mapSymbols = {
    SI_PREFIXES.base: null,
    SI_PREFIXES.deca: 'da-',
    SI_PREFIXES.hecto: 'h-',
    SI_PREFIXES.kilo: 'k-',
    SI_PREFIXES.mega: 'M-',
    SI_PREFIXES.giga: 'G-',
    SI_PREFIXES.tera: 'T-',
    SI_PREFIXES.peta: 'P-',
    SI_PREFIXES.exa: 'E-',
    SI_PREFIXES.zetta: 'Z-',
    SI_PREFIXES.yotta: 'Y-',
    SI_PREFIXES.deci: 'd-',
    SI_PREFIXES.centi: 'c-',
    SI_PREFIXES.milli: 'm-',
    SI_PREFIXES.micro: 'µ-',
    SI_PREFIXES.nano: 'n-',
    SI_PREFIXES.pico: 'p-',
    SI_PREFIXES.femto: 'f-',
    SI_PREFIXES.atto: 'a-',
    SI_PREFIXES.zepto: 'z-',
    SI_PREFIXES.yocto: 'y-',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _si_prefixes_conversion;

  ///Class for si_prefixes conversions, e.g. if you want to convert 1 base unit in milli:
  ///```dart
  ///var si_prefixes = Si_Prefixes(removeTrailingZeros: false);
  ///si_prefixes.Convert(Unit(SI_PREFIXES.base, value: 1));
  ///print(SI_PREFIXES.milli);
  /// ```
  Si_Prefixes({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    SI_PREFIXES.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _si_prefixes_conversion = Node(name: SI_PREFIXES.base, leafNodes: [
      Node(
        coefficientProduct: 1e1,
        name: SI_PREFIXES.deca,
      ),
      Node(
        coefficientProduct: 1e2,
        name: SI_PREFIXES.hecto,
      ),
      Node(
        coefficientProduct: 1e3,
        name: SI_PREFIXES.kilo,
      ),
      Node(
        coefficientProduct: 1e6,
        name: SI_PREFIXES.mega,
      ),
      Node(
        coefficientProduct: 1e9,
        name: SI_PREFIXES.giga,
      ),
      Node(
        coefficientProduct: 1e12,
        name: SI_PREFIXES.tera,
      ),
      Node(
        coefficientProduct: 1e15,
        name: SI_PREFIXES.peta,
      ),
      Node(
        coefficientProduct: 1e18,
        name: SI_PREFIXES.exa,
      ),
      Node(
        coefficientProduct: 1e21,
        name: SI_PREFIXES.zetta,
      ),
      Node(
        coefficientProduct: 1e24,
        name: SI_PREFIXES.yotta,
      ),
      Node(
        coefficientProduct: 1e-1,
        name: SI_PREFIXES.deci,
      ),
      Node(
        coefficientProduct: 1e-2,
        name: SI_PREFIXES.centi,
      ),
      Node(
        coefficientProduct: 1e-3,
        name: SI_PREFIXES.milli,
      ),
      Node(
        coefficientProduct: 1e-6,
        name: SI_PREFIXES.micro,
      ),
      Node(
        coefficientProduct: 1e-9,
        name: SI_PREFIXES.nano,
      ),
      Node(
        coefficientProduct: 1e-12,
        name: SI_PREFIXES.pico,
      ),
      Node(
        coefficientProduct: 1e-15,
        name: SI_PREFIXES.femto,
      ),
      Node(
        coefficientProduct: 1e-18,
        name: SI_PREFIXES.atto,
      ),
      Node(
        coefficientProduct: 1e-21,
        name: SI_PREFIXES.zepto,
      ),
      Node(
        coefficientProduct: 1e-24,
        name: SI_PREFIXES.yocto,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(SI_PREFIXES.values.contains(unit.name));
    _si_prefixes_conversion.clearAllValues();
    _si_prefixes_conversion.clearSelectedNode();
    var currentUnit = _si_prefixes_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _si_prefixes_conversion.convert();
    for (var i = 0; i < SI_PREFIXES.values.length; i++) {
      areaUnitList[i].value = _si_prefixes_conversion.getByName(SI_PREFIXES.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get base => _getUnit(SI_PREFIXES.base);
  Unit get deca => _getUnit(SI_PREFIXES.deca);
  Unit get hecto => _getUnit(SI_PREFIXES.hecto);
  Unit get kilo => _getUnit(SI_PREFIXES.kilo);
  Unit get mega => _getUnit(SI_PREFIXES.mega);
  Unit get giga => _getUnit(SI_PREFIXES.giga);
  Unit get tera => _getUnit(SI_PREFIXES.tera);
  Unit get peta => _getUnit(SI_PREFIXES.peta);
  Unit get exa => _getUnit(SI_PREFIXES.exa);
  Unit get zetta => _getUnit(SI_PREFIXES.zetta);
  Unit get yotta => _getUnit(SI_PREFIXES.yotta);
  Unit get deci => _getUnit(SI_PREFIXES.deci);
  Unit get centi => _getUnit(SI_PREFIXES.centi);
  Unit get milli => _getUnit(SI_PREFIXES.milli);
  Unit get micro => _getUnit(SI_PREFIXES.micro);
  Unit get nano => _getUnit(SI_PREFIXES.nano);
  Unit get pico => _getUnit(SI_PREFIXES.pico);
  Unit get femto => _getUnit(SI_PREFIXES.femto);
  Unit get atto => _getUnit(SI_PREFIXES.atto);
  Unit get zepto => _getUnit(SI_PREFIXES.zepto);
  Unit get yocto => _getUnit(SI_PREFIXES.yocto);

  ///Returns all the si_prefixes units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
