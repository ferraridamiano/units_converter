import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available length units
enum LENGTH {
  meters,
  centimeters,
  inches,
  feet,
  feetUs,
  nauticalMiles,
  yards,
  miles,
  millimeters,
  micrometers,
  nanometers,
  angstroms,
  picometers,
  kilometers,
  astronomicalUnits,
  lightYears,
  parsec,
  mils,
}

class Length extends Property<LENGTH, double> {
  /// Map between units and its symbol
  static const Map<LENGTH, String?> mapSymbols = {
    LENGTH.meters: 'm',
    LENGTH.centimeters: 'cm',
    LENGTH.inches: 'in',
    LENGTH.feet: 'ft',
    LENGTH.feetUs: 'ft(US survey)',
    LENGTH.nauticalMiles: 'M',
    LENGTH.yards: 'yd',
    LENGTH.miles: 'mi',
    LENGTH.millimeters: 'mm',
    LENGTH.micrometers: 'µm',
    LENGTH.nanometers: 'nm',
    LENGTH.angstroms: 'Å',
    LENGTH.picometers: 'pm',
    LENGTH.kilometers: 'km',
    LENGTH.astronomicalUnits: 'au',
    LENGTH.lightYears: 'ly',
    LENGTH.parsec: 'pc',
    LENGTH.mils: null,
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  /// Whether to use the scientific notation (true) for [stringValue]s or
  /// decimal notation (false)
  bool useScientificNotation;

  late CustomConversion _customConversion;

  ///Class for length conversions, e.g. if you want to convert 1 meter in inches:
  ///```dart
  ///var length = Length(removeTrailingZeros: false);
  ///length.convert(Unit(LENGTH.meters, value: 1));
  ///print(length.inches);
  /// ```
  Length(
      {this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true,
      name}) {
    this.name = name ?? PROPERTY.length;
    size = LENGTH.values.length;
    Node conversionTree = Node(name: LENGTH.meters, leafNodes: [
      Node(coefficientProduct: 0.01, name: LENGTH.centimeters, leafNodes: [
        Node(coefficientProduct: 2.54, name: LENGTH.inches, leafNodes: [
          Node(
            coefficientProduct: 12.0,
            name: LENGTH.feet,
          ),
          Node(
            coefficientProduct: 12.000024,
            name: LENGTH.feetUs,
          ),
          Node(
            coefficientProduct: 1e-3,
            name: LENGTH.mils,
          ),
        ]),
      ]),
      Node(
        coefficientProduct: 1852.0,
        name: LENGTH.nauticalMiles,
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
        Node(
            coefficientProduct: 149597870.7,
            name: LENGTH.astronomicalUnits,
            leafNodes: [
              Node(
                  coefficientProduct: 63241.1,
                  name: LENGTH.lightYears,
                  leafNodes: [
                    Node(
                      coefficientProduct: 3.26,
                      name: LENGTH.parsec,
                    ),
                  ]),
            ]),
      ]),
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        useScientificNotation: useScientificNotation);
  }

  ///Converts a unit with a specific name (e.g. LENGTH.meters) and value to all other units
  @override
  void convert(LENGTH name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get meters => getUnit(LENGTH.meters);
  Unit get centimeters => getUnit(LENGTH.centimeters);
  Unit get inches => getUnit(LENGTH.inches);
  Unit get feet => getUnit(LENGTH.feet);
  Unit get feetUs => getUnit(LENGTH.feetUs);
  Unit get nauticalMiles => getUnit(LENGTH.nauticalMiles);
  Unit get yards => getUnit(LENGTH.yards);
  Unit get miles => getUnit(LENGTH.miles);
  Unit get millimeters => getUnit(LENGTH.millimeters);
  Unit get micrometers => getUnit(LENGTH.micrometers);
  Unit get nanometers => getUnit(LENGTH.nanometers);
  Unit get angstroms => getUnit(LENGTH.angstroms);
  Unit get picometers => getUnit(LENGTH.picometers);
  Unit get kilometers => getUnit(LENGTH.kilometers);
  Unit get astronomicalUnits => getUnit(LENGTH.astronomicalUnits);
  Unit get lightYears => getUnit(LENGTH.lightYears);
  Unit get parsec => getUnit(LENGTH.parsec);
  Unit get mils => getUnit(LENGTH.mils);
}
