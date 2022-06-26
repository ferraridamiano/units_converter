import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';
import 'package:units_converter/utils/utils.dart';

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

  /// unified atomic mass unit
  uma,
  carats,
  centigrams,
  pennyweights,
  troyOunces,
  stones,
}

class Mass extends CustomProperty {
  ///Class for mass conversions, e.g. if you want to convert 1 gram in ounces:
  ///```dart
  ///var mass = Mass(removeTrailingZeros: false);
  ///mass.convert(Unit(MASS.grams, value: 1));
  ///print(MASS.ounces);
  /// ```
  Mass(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.mass,
          mapSymbols: {
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
          },
          conversionTree: ConversionNode(name: MASS.grams, leafNodes: [
            ConversionNode(
              coefficientProduct: Rational.fromInt(100),
              name: MASS.ettograms,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000),
              name: MASS.kilograms,
              leafNodes: [
                ConversionNode(
                  coefficientProduct: Rational.parse('0.45359237'),
                  name: MASS.pounds,
                  leafNodes: [
                    ConversionNode(
                      coefficientProduct: fraction(1, 16),
                      name: MASS.ounces,
                    ),
                    ConversionNode(
                      coefficientProduct: Rational.fromInt(14),
                      name: MASS.stones,
                    ),
                  ],
                ),
              ],
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(100000),
              name: MASS.quintals,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000),
              name: MASS.tons,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('1e-2'),
              name: MASS.centigrams,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('1e-3'),
              name: MASS.milligrams,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('1.660539e-24'),
              name: MASS.uma,
            ),
            ConversionNode(
              coefficientProduct: Rational.parse('0.2'),
              name: MASS.carats,
            ),
            ConversionNode(
                coefficientProduct: Rational.parse('1.55517384'),
                name: MASS.pennyweights,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(20),
                    name: MASS.troyOunces,
                  ),
                ]),
          ]),
        );

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
