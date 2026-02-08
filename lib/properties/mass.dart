import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available mass units
enum MASS {
  grams,
  ettograms,
  kilograms,
  pounds,
  ounces,
  quintals,
  tonnes,
  milligrams,
  femtograms,
  picograms,
  nanograms,
  micrograms,
  decigrams,
  grains,

  /// unified atomic mass unit
  uma,
  carats,
  centigrams,
  pennyweights,
  troyOunces,
  stones,
}

class Mass extends DoubleProperty<MASS> {
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
            MASS.tonnes: 't',
            MASS.milligrams: 'mg',
            MASS.uma: 'u',
            MASS.carats: 'ct',
            MASS.centigrams: 'cg',
            MASS.pennyweights: 'dwt',
            MASS.troyOunces: 'oz t',
            MASS.stones: 'st.',
            MASS.femtograms: 'fg',
            MASS.picograms: 'pg',
            MASS.nanograms: 'ng',
            MASS.micrograms: 'µg',
            MASS.decigrams: 'dg',
            MASS.grains: 'gr',
          },
          conversionTree: ConversionNode(name: MASS.grams, children: [
            ConversionNode(
              coefficientProduct: 100.0,
              name: MASS.ettograms,
            ),
            ConversionNode(
              coefficientProduct: 1000.0,
              name: MASS.kilograms,
              children: [
                ConversionNode(
                  coefficientProduct: 0.45359237,
                  name: MASS.pounds,
                  children: [
                    ConversionNode(
                      coefficientProduct: 1 / 16,
                      name: MASS.ounces,
                    ),
                    ConversionNode(
                      coefficientProduct: 14,
                      name: MASS.stones,
                    ),
                  ],
                ),
              ],
            ),
            ConversionNode(
              coefficientProduct: 100000.0,
              name: MASS.quintals,
            ),
            ConversionNode(
              coefficientProduct: 1000000.0,
              name: MASS.tonnes,
            ),
            ConversionNode(
              coefficientProduct: 1e-2,
              name: MASS.centigrams,
            ),
            ConversionNode(
              coefficientProduct: 1e-3,
              name: MASS.milligrams,
            ),
            ConversionNode(
              coefficientProduct: 1.660539e-24,
              name: MASS.uma,
            ),
            ConversionNode(
              coefficientProduct: 0.2,
              name: MASS.carats,
            ),
            ConversionNode(
                coefficientProduct: 1.55517384,
                name: MASS.pennyweights,
                children: [
                  ConversionNode(
                    coefficientProduct: 20,
                    name: MASS.troyOunces,
                  ),
                ]),
            ConversionNode(
              coefficientProduct: 1e-15,
              name: MASS.femtograms,
            ),
            ConversionNode(
              coefficientProduct: 1e-12,
              name: MASS.picograms,
            ),
            ConversionNode(
              coefficientProduct: 1e-9,
              name: MASS.nanograms,
            ),
            ConversionNode(
              coefficientProduct: 1e-6,
              name: MASS.micrograms,
            ),
            ConversionNode(
              coefficientProduct: 0.1,
              name: MASS.decigrams,
            ),
            ConversionNode(
              coefficientProduct: 0.06479891,
              name: MASS.grains,
            ),
          ]),
        );

  Unit get grams => getUnit(MASS.grams);
  Unit get ettograms => getUnit(MASS.ettograms);
  Unit get kilograms => getUnit(MASS.kilograms);
  Unit get pounds => getUnit(MASS.pounds);
  Unit get ounces => getUnit(MASS.ounces);
  Unit get quintals => getUnit(MASS.quintals);
  Unit get tons => getUnit(MASS.tonnes);
  Unit get milligrams => getUnit(MASS.milligrams);
  Unit get uma => getUnit(MASS.uma);
  Unit get carats => getUnit(MASS.carats);
  Unit get centigrams => getUnit(MASS.centigrams);
  Unit get pennyweights => getUnit(MASS.pennyweights);
  Unit get troyOunces => getUnit(MASS.troyOunces);
  Unit get stones => getUnit(MASS.stones);
  Unit get femtograms => getUnit(MASS.femtograms);
  Unit get picograms => getUnit(MASS.picograms);
  Unit get nanograms => getUnit(MASS.nanograms);
  Unit get micrograms => getUnit(MASS.micrograms);
  Unit get decigrams => getUnit(MASS.decigrams);
  Unit get grains => getUnit(MASS.grains);
}
