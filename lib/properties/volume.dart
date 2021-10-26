import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

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
  //Map between units and its symbol
  final Map<VOLUME, String> mapSymbols = {
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

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for volume conversions, e.g. if you want to convert 1 liter in US Gallons:
  ///```dart
  ///var volume = Volume(removeTrailingZeros: false);
  ///volume.convert(Unit(VOLUME.liters, value: 1));
  ///print(VOLUME.us_gallons);
  /// ```
  Volume(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = VOLUME.values.length;
    this.name = name ?? PROPERTY.volume;
    for (VOLUME val in VOLUME.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(
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
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. VOLUME.cubic_feet) and value to all other units
  @override
  void convert(VOLUME name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < VOLUME.values.length; i++) {
      unitList[i].value = getNodeByName(VOLUME.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(
          unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

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
