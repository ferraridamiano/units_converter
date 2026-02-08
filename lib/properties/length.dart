import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available length units
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

class Length extends DoubleProperty<LENGTH> {
  ///Class for length conversions, e.g. if you want to convert 1 meter in inches:
  ///```dart
  ///var length = Length(removeTrailingZeros: false);
  ///length.convert(Unit(LENGTH.meters, value: 1));
  ///print(length.inches);
  /// ```
  Length(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
            name: name ?? PROPERTY.length,
            mapSymbols: {
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
              LENGTH.mils: 'th',
            },
            conversionTree: ConversionNode(name: LENGTH.meters, children: [
              ConversionNode(
                  coefficientProduct: 0.01,
                  name: LENGTH.centimeters,
                  children: [
                    ConversionNode(
                        coefficientProduct: 2.54,
                        name: LENGTH.inches,
                        children: [
                          ConversionNode(
                            coefficientProduct: 12.0,
                            name: LENGTH.feet,
                          ),
                          ConversionNode(
                            coefficientProduct: 12.000024,
                            name: LENGTH.feetUs,
                          ),
                          ConversionNode(
                            coefficientProduct: 1e-3,
                            name: LENGTH.mils,
                          ),
                        ]),
                  ]),
              ConversionNode(
                coefficientProduct: 1852.0,
                name: LENGTH.nauticalMiles,
              ),
              ConversionNode(
                  coefficientProduct: 0.9144,
                  name: LENGTH.yards,
                  children: [
                    ConversionNode(
                      coefficientProduct: 1760.0,
                      name: LENGTH.miles,
                    ),
                  ]),
              ConversionNode(
                coefficientProduct: 1e-3,
                name: LENGTH.millimeters,
              ),
              ConversionNode(
                coefficientProduct: 1e-6,
                name: LENGTH.micrometers,
              ),
              ConversionNode(
                coefficientProduct: 1e-9,
                name: LENGTH.nanometers,
              ),
              ConversionNode(
                coefficientProduct: 1e-10,
                name: LENGTH.angstroms,
              ),
              ConversionNode(
                coefficientProduct: 1e-12,
                name: LENGTH.picometers,
              ),
              ConversionNode(
                  coefficientProduct: 1000.0,
                  name: LENGTH.kilometers,
                  children: [
                    ConversionNode(
                        coefficientProduct: 149597870.7,
                        name: LENGTH.astronomicalUnits,
                        children: [
                          ConversionNode(
                              coefficientProduct: 63241.1,
                              name: LENGTH.lightYears,
                              children: [
                                ConversionNode(
                                  coefficientProduct: 3.26,
                                  name: LENGTH.parsec,
                                ),
                              ]),
                        ]),
                  ]),
            ]));

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
