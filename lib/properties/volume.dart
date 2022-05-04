import 'package:units_converter/models/node.dart';
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

class Volume extends Property<VOLUME, double> {
  /// Map between units and its symbol
  static const Map<VOLUME, String?> mapSymbols = {
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

  ///Class for volume conversions, e.g. if you want to convert 1 liter in US Gallons:
  ///```dart
  ///var volume = Volume(removeTrailingZeros: false);
  ///volume.convert(Unit(VOLUME.liters, value: 1));
  ///print(VOLUME.us_gallons);
  /// ```
  Volume(
      {this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true,
      name}) {
    this.name = name ?? PROPERTY.volume;
    size = VOLUME.values.length;
    Node conversionTree = Node(
      name: VOLUME.cubicMeters,
      leafNodes: [
        Node(coefficientProduct: 1e-3, name: VOLUME.liters, leafNodes: [
          Node(
            coefficientProduct: 4.54609,
            name: VOLUME.imperialGallons,
          ),
          Node(
            coefficientProduct: 3.785411784,
            name: VOLUME.usGallons,
          ),
          Node(
            coefficientProduct: 0.56826125,
            name: VOLUME.imperialPints,
            leafNodes: [
              Node(
                coefficientProduct: 1 / 20,
                name: VOLUME.imperialFluidOunces,
                leafNodes: [
                  Node(coefficientProduct: 5, name: VOLUME.imperialGill),
                ],
              ),
            ],
          ),
          Node(
            coefficientProduct: 0.473176473,
            name: VOLUME.usPints,
            leafNodes: [
              Node(
                coefficientProduct: 1 / 16,
                name: VOLUME.usFluidOunces,
                leafNodes: [
                  Node(
                    coefficientProduct: 4,
                    name: VOLUME.usGill,
                  ),
                ],
              ),
            ],
          ),
          Node(coefficientProduct: 1e-3, name: VOLUME.milliliters, leafNodes: [
            Node(
              coefficientProduct: 14.8,
              name: VOLUME.tablespoonsUs,
            ),
            Node(
              coefficientProduct: 20.0,
              name: VOLUME.australianTablespoons,
            ),
            Node(
              coefficientProduct: 240.0,
              name: VOLUME.cups,
            ),
          ]),
        ]),
        Node(
            coefficientProduct: 1e-6,
            name: VOLUME.cubicCentimeters,
            leafNodes: [
              Node(
                  coefficientProduct: 16.387064,
                  name: VOLUME.cubicInches,
                  leafNodes: [
                    Node(
                      coefficientProduct: 1728.0,
                      name: VOLUME.cubicFeet,
                    ),
                  ]),
            ]),
        Node(
          coefficientProduct: 1e-9,
          name: VOLUME.cubicMillimeters,
        ),
      ],
    );

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        useScientificNotation: useScientificNotation);
  }

  ///Converts a unit with a specific name (e.g. VOLUME.cubic_feet) and value to all other units
  @override
  void convert(VOLUME name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

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
