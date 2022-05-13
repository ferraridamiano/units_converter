import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available VOLUME units
enum VOLUME {
  cubicMeters,
  liters,
  imperialGallons,
  usGallons,
  imperialPints,
  usPints,
  milliliters,
  tablespoonsUs,
  australianTablespoons,
  cups,
  cubicCentimeters,
  cubicFeet,
  cubicInches,
  cubicMillimeters,
  imperialFluidOunces,
  usFluidOunces,
  imperialGill,
  usGill,
}

class Volume extends CustomConversion {
  ///Class for volume conversions, e.g. if you want to convert 1 liter in US Gallons:
  ///```dart
  ///var volume = Volume(removeTrailingZeros: false);
  ///volume.convert(Unit(VOLUME.liters, value: 1));
  ///print(VOLUME.us_gallons);
  /// ```
  Volume(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.volume,
          mapSymbols: {
            VOLUME.cubicMeters: 'm³',
            VOLUME.liters: 'l',
            VOLUME.imperialGallons: 'imp gal',
            VOLUME.usGallons: 'US gal',
            VOLUME.imperialPints: 'imp pt',
            VOLUME.usPints: 'US pt',
            VOLUME.milliliters: 'ml',
            VOLUME.tablespoonsUs: 'tbsp.',
            VOLUME.australianTablespoons: 'tbsp.',
            VOLUME.cups: 'cup',
            VOLUME.cubicCentimeters: 'cm³',
            VOLUME.cubicFeet: 'ft³',
            VOLUME.cubicInches: 'in³',
            VOLUME.cubicMillimeters: 'mm³',
            VOLUME.imperialFluidOunces: 'imp fl oz',
            VOLUME.usFluidOunces: 'US fl oz',
            VOLUME.imperialGill: 'Imp. gi.',
            VOLUME.usGill: 'US. liq. gi',
          },
          conversionTree: ConversionNode(name: VOLUME.cubicMeters, leafNodes: [
            ConversionNode(coefficientProduct: 1e-3, name: VOLUME.liters, leafNodes: [
              ConversionNode(
                coefficientProduct: 4.54609,
                name: VOLUME.imperialGallons,
              ),
              ConversionNode(
                coefficientProduct: 3.785411784,
                name: VOLUME.usGallons,
              ),
              ConversionNode(
                coefficientProduct: 0.56826125,
                name: VOLUME.imperialPints,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: 1 / 20,
                    name: VOLUME.imperialFluidOunces,
                    leafNodes: [
                      ConversionNode(coefficientProduct: 5, name: VOLUME.imperialGill),
                    ],
                  ),
                ],
              ),
              ConversionNode(
                coefficientProduct: 0.473176473,
                name: VOLUME.usPints,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: 1 / 16,
                    name: VOLUME.usFluidOunces,
                    leafNodes: [
                      ConversionNode(
                        coefficientProduct: 4,
                        name: VOLUME.usGill,
                      ),
                    ],
                  ),
                ],
              ),
              ConversionNode(
                  coefficientProduct: 1e-3,
                  name: VOLUME.milliliters,
                  leafNodes: [
                    ConversionNode(
                      coefficientProduct: 14.8,
                      name: VOLUME.tablespoonsUs,
                    ),
                    ConversionNode(
                      coefficientProduct: 20.0,
                      name: VOLUME.australianTablespoons,
                    ),
                    ConversionNode(
                      coefficientProduct: 240.0,
                      name: VOLUME.cups,
                    ),
                  ]),
            ]),
            ConversionNode(
                coefficientProduct: 1e-6,
                name: VOLUME.cubicCentimeters,
                leafNodes: [
                  ConversionNode(
                      coefficientProduct: 16.387064,
                      name: VOLUME.cubicInches,
                      leafNodes: [
                        ConversionNode(
                          coefficientProduct: 1728.0,
                          name: VOLUME.cubicFeet,
                        ),
                      ]),
                ]),
            ConversionNode(
              coefficientProduct: 1e-9,
              name: VOLUME.cubicMillimeters,
            ),
          ]),
        );

  Unit get cubicMeters => getUnit(VOLUME.cubicMeters);
  Unit get liters => getUnit(VOLUME.liters);
  Unit get imperialGallons => getUnit(VOLUME.imperialGallons);
  Unit get usGallons => getUnit(VOLUME.usGallons);
  Unit get imperialPints => getUnit(VOLUME.imperialPints);
  Unit get usPints => getUnit(VOLUME.usPints);
  Unit get milliliters => getUnit(VOLUME.milliliters);
  Unit get tablespoonsUs => getUnit(VOLUME.tablespoonsUs);
  Unit get australianTablespoons => getUnit(VOLUME.australianTablespoons);
  Unit get cups => getUnit(VOLUME.cups);
  Unit get cubicCentimeters => getUnit(VOLUME.cubicCentimeters);
  Unit get cubicFeet => getUnit(VOLUME.cubicFeet);
  Unit get cubicInches => getUnit(VOLUME.cubicInches);
  Unit get cubicMillimeters => getUnit(VOLUME.cubicMillimeters);
  Unit get imperialFluidOunces => getUnit(VOLUME.imperialFluidOunces);
  Unit get usFluidOunces => getUnit(VOLUME.usFluidOunces);
  Unit get imperialGill => getUnit(VOLUME.imperialGill);
  Unit get usGill => getUnit(VOLUME.usGill);
}
