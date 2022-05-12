import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

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

class Area extends CustomConversion {
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
          conversionTree: Node(name: AREA.squareMeters, leafNodes: [
            Node(
                coefficientProduct: 1e-4,
                name: AREA.squareCentimeters,
                leafNodes: [
                  Node(
                      coefficientProduct: 6.4516,
                      name: AREA.squareInches,
                      leafNodes: [
                        Node(
                          coefficientProduct: 144.0,
                          name: AREA.squareFeet,
                        ),
                        Node(
                          coefficientProduct: 12.000024 * 12.000024,
                          name: AREA.squareFeetUs,
                        ),
                      ]),
                ]),
            Node(
              coefficientProduct: 1e-6,
              name: AREA.squareMillimeters,
            ),
            Node(
              coefficientProduct: 10000.0,
              name: AREA.hectares,
            ),
            Node(
              coefficientProduct: 1000000.0,
              name: AREA.squareKilometers,
            ),
            Node(
              coefficientProduct: 0.83612736,
              name: AREA.squareYard,
              leafNodes: [
                Node(
                  coefficientProduct: 3097600.0,
                  name: AREA.squareMiles,
                ),
                Node(
                  coefficientProduct: 4840.0,
                  name: AREA.acres,
                ),
              ],
            ),
            Node(
              coefficientProduct: 100.0,
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
