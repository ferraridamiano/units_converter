import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';
import 'package:units_converter/utils/utils.dart';

//Available SPEED units
enum SPEED {
  metersPerSecond,
  kilometersPerHour,
  milesPerHour,
  knots,
  feetsPerSecond,
  minutesPerKilometer,
}

class Speed extends CustomProperty {
  ///Class for speed conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var speed = Speed(removeTrailingZeros: false);
  ///speed.convert(Unit(SPEED.square_meters, value: 1));
  ///print(SPEED.acres);
  /// ```
  Speed(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.speed,
          mapSymbols: {
            SPEED.metersPerSecond: 'm/s',
            SPEED.kilometersPerHour: 'km/h',
            SPEED.milesPerHour: 'mi/h',
            SPEED.knots: 'kts',
            SPEED.feetsPerSecond: 'ft/s',
            SPEED.minutesPerKilometer: 'min/km',
          },
          conversionTree:
              ConversionNode(name: SPEED.metersPerSecond, leafNodes: [
            ConversionNode(
                coefficientProduct: fraction(10, 36),
                name: SPEED.kilometersPerHour,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: Rational.parse('1.609344'),
                    name: SPEED.milesPerHour,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.parse('1.852'),
                    name: SPEED.knots,
                  ),
                  ConversionNode(
                    conversionType: ConversionType.reciprocalConversion,
                    coefficientProduct: Rational.fromInt(60),
                    name: SPEED.minutesPerKilometer,
                  )
                ]),
            ConversionNode(
              coefficientProduct: Rational.parse('0.3048'),
              name: SPEED.feetsPerSecond,
            ),
          ]),
        );

  Unit get metersPerSecond => getUnit(SPEED.metersPerSecond);
  Unit get kilometersPerHour => getUnit(SPEED.kilometersPerHour);
  Unit get milesPerHour => getUnit(SPEED.milesPerHour);
  Unit get knots => getUnit(SPEED.knots);
  Unit get feetsPerSecond => getUnit(SPEED.feetsPerSecond);
  Unit get minutesPerKilometer => getUnit(SPEED.minutesPerKilometer);
}
