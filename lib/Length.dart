import 'UtilsConversion.dart';
import 'Unit.dart';

//Available length units
enum LENGTH {
  meters,
  centimeters,
  inches,
  feet,
  nautical_miles,
  yards,
  miles,
  millimeters,
  micrometers,
  nanometers,
  angstroms,
  picometers,
  kilometers,
  astronomical_units,
  light_years,
  parsec,
}

class Length {
  //Map between units and its symbol
  final Map<LENGTH, String> mapSymbols = {
    LENGTH.meters: 'm',
    LENGTH.centimeters: 'cm',
    LENGTH.inches: 'in',
    LENGTH.feet: 'ft',
    LENGTH.nautical_miles: 'M',
    LENGTH.yards: 'yd',
    LENGTH.miles: 'mi',
    LENGTH.millimeters: 'mm',
    LENGTH.micrometers: 'µm',
    LENGTH.nanometers: 'nm',
    LENGTH.angstroms: 'Å',
    LENGTH.picometers: 'pm',
    LENGTH.kilometers: 'km',
    LENGTH.astronomical_units: 'au',
    LENGTH.light_years: 'ly',
    LENGTH.parsec: 'pc',
  };

  int significantFigures;
  bool removeTrailingZeros;
  List<Unit> unitList = [];
  Node _unit_conversion;

  ///Class for length conversions, e.g. if you want to convert 1 meter in inches:
  ///```dart
  ///var length = Length(removeTrailingZeros: false);
  ///length.Convert(Unit(LENGTH.meters, value: 1));
  ///print(length.inches);
  /// ```
  Length({int significantFigures = 10, bool removeTrailingZeros = true}) {
    this.significantFigures = significantFigures;
    this.removeTrailingZeros = removeTrailingZeros;
    LENGTH.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    _unit_conversion = Node(name: LENGTH.meters, leafNodes: [
      Node(coefficientProduct: 0.01, name: LENGTH.centimeters, leafNodes: [
        Node(coefficientProduct: 2.54, name: LENGTH.inches, leafNodes: [
          Node(
            coefficientProduct: 12.0,
            name: LENGTH.feet,
          ),
        ]),
      ]),
      Node(
        coefficientProduct: 1852.0,
        name: LENGTH.nautical_miles,
      ),
      Node(coefficientProduct: 0.9144, name: LENGTH.yards, leafNodes: [
        Node(
          coefficientProduct: 1760.0,
          name: LENGTH.miles,
        ),
      ]),
      Node(
        coefficientProduct: 1e-3,
        name: LENGTH.millimeters,
      ),
      Node(
        coefficientProduct: 1e-6,
        name: LENGTH.micrometers,
      ),
      Node(
        coefficientProduct: 1e-9,
        name: LENGTH.nanometers,
      ),
      Node(
        coefficientProduct: 1e-10,
        name: LENGTH.angstroms,
      ),
      Node(
        coefficientProduct: 1e-12,
        name: LENGTH.picometers,
      ),
      Node(coefficientProduct: 1000.0, name: LENGTH.kilometers, leafNodes: [
        Node(coefficientProduct: 149597870.7, name: LENGTH.astronomical_units, leafNodes: [
          Node(coefficientProduct: 63241.1, name: LENGTH.light_years, leafNodes: [
            Node(
              coefficientProduct: 3.26,
              name: LENGTH.parsec,
            ),
          ]),
        ]),
      ]),
    ]);
  }

  ///Converts a unit with a specific name (e.g. LENGTH.meters) and value to all other units
  void Convert(LENGTH name, double value) {
    _unit_conversion.clearAllValues();
    _unit_conversion.clearSelectedNode();
    var currentUnit = _unit_conversion.getByName(name);
    currentUnit.value = value;
    currentUnit.selectedNode = true;
    currentUnit.convertedNode = true;
    _unit_conversion.convert();
    for (var i = 0; i < LENGTH.values.length; i++) {
      unitList[i].value = _unit_conversion.getByName(LENGTH.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get meters => _getUnit(LENGTH.meters);
  Unit get centimeters => _getUnit(LENGTH.centimeters);
  Unit get inches => _getUnit(LENGTH.inches);
  Unit get feet => _getUnit(LENGTH.feet);
  Unit get nautical_miles => _getUnit(LENGTH.nautical_miles);
  Unit get yards => _getUnit(LENGTH.yards);
  Unit get miles => _getUnit(LENGTH.miles);
  Unit get millimeters => _getUnit(LENGTH.millimeters);
  Unit get micrometers => _getUnit(LENGTH.micrometers);
  Unit get nanometers => _getUnit(LENGTH.nanometers);
  Unit get angstroms => _getUnit(LENGTH.angstroms);
  Unit get picometers => _getUnit(LENGTH.picometers);
  Unit get kilometers => _getUnit(LENGTH.kilometers);
  Unit get astronomical_units => _getUnit(LENGTH.astronomical_units);
  Unit get light_years => _getUnit(LENGTH.light_years);
  Unit get parsec => _getUnit(LENGTH.parsec);

  ///Returns all the length units converted with prefixes
  List<Unit> getAll() {
    return unitList;
  }

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
