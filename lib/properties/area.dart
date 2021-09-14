import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils_conversion.dart';

//Available AREA units
enum AREA {
  squareMeters,
  squareCentimeters,
  squareInches,
  squareFeet,
  squareMiles,
  squareYard,
  squareMillimeters,
  squareKilometers,
  hectares,
  acres,
  are,
}

class Area extends Property<AREA, double> {
  //Map between units and its symbol
  final Map<AREA, String> mapSymbols = {
    AREA.squareMeters: 'm²',
    AREA.squareCentimeters: 'cm²',
    AREA.squareInches: 'in²',
    AREA.squareFeet: 'ft²',
    AREA.squareMiles: 'mi²',
    AREA.squareYard: 'yd²',
    AREA.squareMillimeters: 'mm²',
    AREA.squareKilometers: 'km²',
    AREA.hectares: 'he',
    AREA.acres: 'ac',
    AREA.are: 'a',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for area conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var area = Area(removeTrailingZeros: false);
  ///area.convert(Unit(AREA.square_meters, value: 1));
  ///print(AREA.acres);
  /// ```
  Area({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = AREA.values.length;
    this.name = name ?? PROPERTY.area;
    for (AREA val in AREA.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: AREA.squareMeters, leafNodes: [
      Node(coefficientProduct: 1e-4, name: AREA.squareCentimeters, leafNodes: [
        Node(coefficientProduct: 6.4516, name: AREA.squareInches, leafNodes: [
          Node(
            coefficientProduct: 144.0,
            name: AREA.squareFeet,
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
      Node(coefficientProduct: 0.83612736, name: AREA.squareYard, leafNodes: [
        Node(
          coefficientProduct: 3097600.0,
          name: AREA.squareMiles,
        ),
        Node(
          coefficientProduct: 4840.0,
          name: AREA.acres,
        ),
      ]),
      Node(
        coefficientProduct: 100.0,
        name: AREA.are,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. AREA.hectares) and value to all other units
  @override
  void convert(AREA name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < AREA.values.length; i++) {
      unitList[i].value = unitConversion.getByName(AREA.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get squareMeters => getUnit(AREA.squareMeters);
  Unit get squareCentimeters => getUnit(AREA.squareCentimeters);
  Unit get squareInches => getUnit(AREA.squareInches);
  Unit get squareFeet => getUnit(AREA.squareFeet);
  Unit get squareMiles => getUnit(AREA.squareMiles);
  Unit get squareYard => getUnit(AREA.squareYard);
  Unit get squareMillimeters => getUnit(AREA.squareMillimeters);
  Unit get squareKilometers => getUnit(AREA.squareKilometers);
  Unit get hectares => getUnit(AREA.hectares);
  Unit get acres => getUnit(AREA.acres);
  Unit get are => getUnit(AREA.are);
}
