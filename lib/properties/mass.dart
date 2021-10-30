import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available MASS units
enum MASS {
  grams,
  ettograms,
  kilograms,
  pounds,
  ounces,
  quintals,
  tons,
  milligrams,
  uma, //unified atomic mass unit
  carats,
  centigrams,
  pennyweights,
  troyOunces,
  stones,
}

class Mass extends Property<MASS, double> {
  ///Map between units and its symbol
  final Map<MASS, String> mapSymbols = {
    MASS.grams: 'g',
    MASS.ettograms: 'hg',
    MASS.kilograms: 'kg',
    MASS.pounds: 'lb',
    MASS.ounces: 'oz',
    MASS.tons: 't',
    MASS.milligrams: 'mg',
    MASS.uma: 'u',
    MASS.carats: 'ct',
    MASS.centigrams: 'cg',
    MASS.pennyweights: 'dwt',
    MASS.troyOunces: 'oz t',
    MASS.stones: 'st.',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for mass conversions, e.g. if you want to convert 1 gram in ounces:
  ///```dart
  ///var mass = Mass(removeTrailingZeros: false);
  ///mass.convert(Unit(MASS.grams, value: 1));
  ///print(MASS.ounces);
  /// ```
  Mass({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(
      name: MASS.grams,
      leafNodes: [
        Node(
          coefficientProduct: 100.0,
          name: MASS.ettograms,
        ),
        Node(
          coefficientProduct: 1000.0,
          name: MASS.kilograms,
          leafNodes: [
            Node(
              coefficientProduct: 0.45359237,
              name: MASS.pounds,
              leafNodes: [
                Node(
                  coefficientProduct: 1 / 16,
                  name: MASS.ounces,
                ),
                Node(
                  coefficientProduct: 14,
                  name: MASS.stones,
                ),
              ],
            ),
          ],
        ),
        Node(
          coefficientProduct: 100000.0,
          name: MASS.quintals,
        ),
        Node(
          coefficientProduct: 1000000.0,
          name: MASS.tons,
        ),
        Node(
          coefficientProduct: 1e-2,
          name: MASS.centigrams,
        ),
        Node(
          coefficientProduct: 1e-3,
          name: MASS.milligrams,
        ),
        Node(
          coefficientProduct: 1.660539e-24,
          name: MASS.uma,
        ),
        Node(
          coefficientProduct: 0.2,
          name: MASS.carats,
        ),
        Node(
          coefficientProduct: 1.55517384,
          name: MASS.pennyweights,
          leafNodes: [
            Node(
              coefficientProduct: 20,
              name: MASS.troyOunces,
            ),
          ],
        ),
      ],
    );

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. MASS.centigrams) and value to all other units
  @override
  void convert(MASS name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get grams => getUnit(MASS.grams);
  Unit get ettograms => getUnit(MASS.ettograms);
  Unit get kilograms => getUnit(MASS.kilograms);
  Unit get pounds => getUnit(MASS.pounds);
  Unit get ounces => getUnit(MASS.ounces);
  Unit get quintals => getUnit(MASS.quintals);
  Unit get tons => getUnit(MASS.tons);
  Unit get milligrams => getUnit(MASS.milligrams);
  Unit get uma => getUnit(MASS.uma);
  Unit get carats => getUnit(MASS.carats);
  Unit get centigrams => getUnit(MASS.centigrams);
  Unit get pennyweights => getUnit(MASS.pennyweights);
  Unit get troyOunces => getUnit(MASS.troyOunces);
  Unit get stones => getUnit(MASS.stones);
}
