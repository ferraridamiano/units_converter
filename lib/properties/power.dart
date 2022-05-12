import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available POWER units
enum POWER {
  watt,
  milliwatt,
  kilowatt,
  megawatt,
  gigawatt,
  europeanHorsePower,
  imperialHorsePower,
}

class Power extends CustomConversion {
  ///Class for power conversions, e.g. if you want to convert 1 kilowatt in european horse power:
  ///```dart
  ///var power = Power(removeTrailingZeros: false);
  ///power.convert(Unit(POWER.kilowatt, value: 1));
  ///print(POWER.european_horse_power);
  /// ```
  Power(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.power,
          mapSymbols: {
            POWER.watt: 'W',
            POWER.milliwatt: 'mW',
            POWER.kilowatt: 'kW',
            POWER.megawatt: 'MW',
            POWER.gigawatt: 'GW',
            POWER.europeanHorsePower: 'hp(M)',
            POWER.imperialHorsePower: 'hp(I)',
          },
          conversionTree: Node(name: POWER.watt, leafNodes: [
            Node(
              coefficientProduct: 1e-3,
              name: POWER.milliwatt,
            ),
            Node(
              coefficientProduct: 1e3,
              name: POWER.kilowatt,
            ),
            Node(
              coefficientProduct: 1e6,
              name: POWER.megawatt,
            ),
            Node(
              coefficientProduct: 1e9,
              name: POWER.gigawatt,
            ),
            Node(
              coefficientProduct: 735.49875,
              name: POWER.europeanHorsePower,
            ),
            Node(
              coefficientProduct: 745.69987158,
              name: POWER.imperialHorsePower,
            ),
          ]),
        );

  Unit get watt => getUnit(POWER.watt);
  Unit get milliwatt => getUnit(POWER.milliwatt);
  Unit get kilowatt => getUnit(POWER.kilowatt);
  Unit get megawatt => getUnit(POWER.megawatt);
  Unit get gigawatt => getUnit(POWER.gigawatt);
  Unit get europeanHorsePower => getUnit(POWER.europeanHorsePower);
  Unit get imperialHorsePower => getUnit(POWER.imperialHorsePower);
}
