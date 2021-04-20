import 'Property.dart';
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
  mils,
}

class Length extends Property<LENGTH, double> {
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

  ///Class for length conversions, e.g. if you want to convert 1 meter in inches:
  ///```dart
  ///var length = Length(removeTrailingZeros: false);
  ///length.convert(Unit(LENGTH.meters, value: 1));
  ///print(length.inches);
  /// ```
  Length({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = LENGTH.values.length;
    this.name = name ?? PROPERTY.LENGTH;
    LENGTH.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: LENGTH.meters, leafNodes: [
      Node(coefficientProduct: 0.01, name: LENGTH.centimeters, leafNodes: [
        Node(coefficientProduct: 2.54, name: LENGTH.inches, leafNodes: [
          Node(
            coefficientProduct: 12.0,
            name: LENGTH.feet,
          ),
          Node(
            coefficientProduct: 1e-3,
            name: LENGTH.mils,
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
  @override
  void convert(LENGTH name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < LENGTH.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(LENGTH.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get meters => getUnit(LENGTH.meters);
  Unit get centimeters => getUnit(LENGTH.centimeters);
  Unit get inches => getUnit(LENGTH.inches);
  Unit get feet => getUnit(LENGTH.feet);
  Unit get nautical_miles => getUnit(LENGTH.nautical_miles);
  Unit get yards => getUnit(LENGTH.yards);
  Unit get miles => getUnit(LENGTH.miles);
  Unit get millimeters => getUnit(LENGTH.millimeters);
  Unit get micrometers => getUnit(LENGTH.micrometers);
  Unit get nanometers => getUnit(LENGTH.nanometers);
  Unit get angstroms => getUnit(LENGTH.angstroms);
  Unit get picometers => getUnit(LENGTH.picometers);
  Unit get kilometers => getUnit(LENGTH.kilometers);
  Unit get astronomical_units => getUnit(LENGTH.astronomical_units);
  Unit get light_years => getUnit(LENGTH.light_years);
  Unit get parsec => getUnit(LENGTH.parsec);
  Unit get mils => getUnit(LENGTH.mils);
}
