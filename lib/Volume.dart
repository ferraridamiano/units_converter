import 'UtilsConversion.dart';
import 'Unit.dart';

//Available VOLUME units
enum VOLUME {
  cubic_meters,
  liters,
  imperial_gallons,
  us_gallons,
  imperial_pints,
  us_pints,
  milliliters,
  tablespoons_us,
  australian_tablespoons,
  cups,
  cubic_centimeters,
  cubic_feet,
  cubic_inches,
  cubic_millimeters,
}

class Volume {
  //Map between units and its symbol
  final Map<VOLUME, String> mapSymbols = {
    VOLUME.cubic_meters: 'm³',
    VOLUME.liters: 'l',
    VOLUME.imperial_gallons: 'imp gal',
    VOLUME.us_gallons: 'US gal',
    VOLUME.imperial_pints: 'imp pt',
    VOLUME.us_pints: 'US pt',
    VOLUME.milliliters: 'ml',
    VOLUME.tablespoons_us: 'tbsp.',
    VOLUME.australian_tablespoons: 'tbsp.',
    VOLUME.cups: 'cup',
    VOLUME.cubic_centimeters: 'cm³',
    VOLUME.cubic_feet: 'ft³',
    VOLUME.cubic_inches: 'in³',
    VOLUME.cubic_millimeters: 'mm³',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> areaUnitList = [];
  Node _volume_conversion;

  ///Class for volume conversions, e.g. if you want to convert 1 liter in US Gallons:
  ///```dart
  ///var volume = Volume(removeTrailingZeros: false);
  ///volume.Convert(Unit(VOLUME.liters, value: 1));
  ///print(VOLUME.us_gallons);
  /// ```
  Volume({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    VOLUME.values.forEach((element) => areaUnitList.add(Unit(element, symbol: mapSymbols[element])));
    _volume_conversion = Node(name: VOLUME.cubic_meters, leafNodes: [
      Node(coefficientProduct: 1e-3, name: VOLUME.liters, leafNodes: [
        Node(
          coefficientProduct: 4.54609,
          name: VOLUME.imperial_gallons,
        ),
        Node(
          coefficientProduct: 3.785411784,
          name: VOLUME.us_gallons,
        ),
        Node(
          coefficientProduct: 0.56826125,
          name: VOLUME.imperial_pints,
        ),
        Node(
          coefficientProduct: 0.473176473,
          name: VOLUME.us_pints,
        ),
        Node(coefficientProduct: 1e-3, name: VOLUME.milliliters, leafNodes: [
          Node(
            coefficientProduct: 14.8,
            name: VOLUME.tablespoons_us,
          ),
          Node(
            coefficientProduct: 20.0,
            name: VOLUME.australian_tablespoons,
          ),
          Node(
            coefficientProduct: 240.0,
            name: VOLUME.cups,
          ),
        ]),
      ]),
      Node(coefficientProduct: 1e-6, name: VOLUME.cubic_centimeters, leafNodes: [
        Node(coefficientProduct: 16.387064, name: VOLUME.cubic_inches, leafNodes: [
          Node(
            coefficientProduct: 1728.0,
            name: VOLUME.cubic_feet,
          ),
        ]),
      ]),
      Node(
        coefficientProduct: 1e-9,
        name: VOLUME.cubic_millimeters,
      ),
    ]);
  }

  ///Converts a Unit (with a specific value and name) to all other units
  void Convert(Unit unit) {
    assert(unit.value != null);
    assert(VOLUME.values.contains(unit.name));
    _volume_conversion.clearAllValues();
    _volume_conversion.clearSelectedNode();
    var currentUnit = _volume_conversion.getByName(unit.name);
    currentUnit.value = unit.value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _volume_conversion.convert();
    for (var i = 0; i < VOLUME.values.length; i++) {
      areaUnitList[i].value = _volume_conversion.getByName(VOLUME.values.elementAt(i)).value;
      areaUnitList[i].stringValue = mantissaCorrection(areaUnitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get cubic_meters => _getUnit(VOLUME.cubic_meters);
  Unit get liters => _getUnit(VOLUME.liters);
  Unit get imperial_gallons => _getUnit(VOLUME.imperial_gallons);
  Unit get us_gallons => _getUnit(VOLUME.us_gallons);
  Unit get imperial_pints => _getUnit(VOLUME.imperial_pints);
  Unit get us_pints => _getUnit(VOLUME.us_pints);
  Unit get milliliters => _getUnit(VOLUME.milliliters);
  Unit get tablespoons_us => _getUnit(VOLUME.tablespoons_us);
  Unit get australian_tablespoons => _getUnit(VOLUME.australian_tablespoons);
  Unit get cups => _getUnit(VOLUME.cups);
  Unit get cubic_centimeters => _getUnit(VOLUME.cubic_centimeters);
  Unit get cubic_feet => _getUnit(VOLUME.cubic_feet);
  Unit get cubic_inches => _getUnit(VOLUME.cubic_inches);
  Unit get cubic_millimeters => _getUnit(VOLUME.cubic_millimeters);

  ///Returns all the volume units converted with prefixes
  List<Unit> getAll() {
    return areaUnitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return areaUnitList.where((element) => element.name == name).first;
  }
}
