import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available AREA units
enum AREA {
  squareMeters,
  squareCentimeters,
  squareInches,
  squareFeet,
  squareFeetUs,
  squareMiles,
  squareYard,
  squareMillimeters,
  squareKilometers,
  hectares,
  acres,
  are,
}

class Area extends CustomProperty {
  ///Class for area conversions, e.g. if you want to convert 1 square meters in
  ///acres:
  ///```dart
  ///var area = Area(removeTrailingZeros: false);
  ///area.convert(Unit(AREA.square_meters, value: 1));
  ///print(AREA.acres);
  /// ```
  Area(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.area,
          mapSymbols: {
            AREA.squareMeters: 'm²',
            AREA.squareCentimeters: 'cm²',
            AREA.squareInches: 'in²',
            AREA.squareFeet: 'ft²',
            AREA.squareFeetUs: 'ft² (US survey)',
            AREA.squareMiles: 'mi²',
            AREA.squareYard: 'yd²',
            AREA.squareMillimeters: 'mm²',
            AREA.squareKilometers: 'km²',
            AREA.hectares: 'ha',
            AREA.acres: 'ac',
            AREA.are: 'a',
          },
          conversionTree: ConversionNode(name: AREA.squareMeters, leafNodes: [
            ConversionNode(
                coefficientProduct: Rational.parse('1e-4'),
                name: AREA.squareCentimeters,
                leafNodes: [
                  ConversionNode(
                      coefficientProduct: Rational.parse('6.4516'),
                      name: AREA.squareInches,
                      leafNodes: [
                        ConversionNode(
                            coefficientProduct: Rational.fromInt(144),
                            name: AREA.squareFeet,
                            leafNodes: [
                              ConversionNode(
                                coefficientProduct: Rational.fromInt(9),
                                name: AREA.squareYard,
                                leafNodes: [
                                  ConversionNode(
                                    coefficientProduct:
                                        Rational.fromInt(3097600),
                                    name: AREA.squareMiles,
                                  ),
                                  ConversionNode(
                                    coefficientProduct: Rational.fromInt(4840),
                                    name: AREA.acres,
                                  ),
                                ],
                              ),
                            ]),
                        ConversionNode(
                          coefficientProduct: Rational.parse('12.000024') *
                              Rational.parse('12.000024'),
                          name: AREA.squareFeetUs,
                        ),
                      ]),
                ]),
            ConversionNode(
              coefficientProduct: Rational.parse('1e-6'),
              name: AREA.squareMillimeters,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(10000),
              name: AREA.hectares,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000),
              name: AREA.squareKilometers,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(100),
              name: AREA.are,
            )
          ]),
        );

  Unit get squareMeters => getUnit(AREA.squareMeters);
  Unit get squareCentimeters => getUnit(AREA.squareCentimeters);
  Unit get squareInches => getUnit(AREA.squareInches);
  Unit get squareFeet => getUnit(AREA.squareFeet);
  Unit get squareFeetUs => getUnit(AREA.squareFeetUs);
  Unit get squareMiles => getUnit(AREA.squareMiles);
  Unit get squareYard => getUnit(AREA.squareYard);
  Unit get squareMillimeters => getUnit(AREA.squareMillimeters);
  Unit get squareKilometers => getUnit(AREA.squareKilometers);
  Unit get hectares => getUnit(AREA.hectares);
  Unit get acres => getUnit(AREA.acres);
  Unit get are => getUnit(AREA.are);
}
