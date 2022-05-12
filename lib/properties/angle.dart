import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available ANGLE units
enum ANGLE {
  degree,
  minutes,
  seconds,
  radians,
}

class Angle extends CustomConversion {
  ///Class for angle conversions, e.g. if you want to convert 1 radiant in degree:
  ///```dart
  ///var angle = Angle(removeTrailingZeros: false);
  ///angle.convert(Unit(ANGLE.radians, value: 1));
  ///print(ANGLE.degree);
  /// ```
  Angle(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.angle,
          mapSymbols: {
            ANGLE.degree: '°',
            ANGLE.minutes: "'",
            ANGLE.seconds: "''",
            ANGLE.radians: 'rad',
          },
          conversionTree: Node(name: ANGLE.degree, leafNodes: [
            Node(
              coefficientProduct: 1 / 60,
              name: ANGLE.minutes,
            ),
            Node(
              coefficientProduct: 1 / 3600,
              name: ANGLE.seconds,
            ),
            Node(
              coefficientProduct: 57.295779513,
              name: ANGLE.radians,
            ),
          ]),
        );

  Unit get degree => getUnit(ANGLE.degree);
  Unit get minutes => getUnit(ANGLE.minutes);
  Unit get seconds => getUnit(ANGLE.seconds);
  Unit get radians => getUnit(ANGLE.radians);
}
