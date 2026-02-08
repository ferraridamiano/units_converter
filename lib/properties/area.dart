import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available area units
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

class Area extends DoubleProperty<AREA> {
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
          conversionTree: ConversionNode(name: AREA.squareMeters, children: [
            ConversionNode(
                coefficientProduct: 1e-4,
                name: AREA.squareCentimeters,
                children: [
                  ConversionNode(
                      coefficientProduct: 6.4516,
                      name: AREA.squareInches,
                      children: [
                        ConversionNode(
                          coefficientProduct: 144.0,
                          name: AREA.squareFeet,
                        ),
                        ConversionNode(
                          coefficientProduct: 12.000024 * 12.000024,
                          name: AREA.squareFeetUs,
                        ),
                      ]),
                ]),
            ConversionNode(
              coefficientProduct: 1e-6,
              name: AREA.squareMillimeters,
            ),
            ConversionNode(
              coefficientProduct: 10000.0,
              name: AREA.hectares,
            ),
            ConversionNode(
              coefficientProduct: 1000000.0,
              name: AREA.squareKilometers,
            ),
            ConversionNode(
              coefficientProduct: 0.83612736,
              name: AREA.squareYard,
              children: [
                ConversionNode(
                  coefficientProduct: 3097600.0,
                  name: AREA.squareMiles,
                ),
                ConversionNode(
                  coefficientProduct: 4840.0,
                  name: AREA.acres,
                ),
              ],
            ),
            ConversionNode(
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
