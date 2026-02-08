import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available speed units
enum SPEED {
  metersPerSecond,
  kilometersPerHour,
  milesPerHour,
  knots,
  feetsPerSecond,
  minutesPerKilometer,
  minutesPerMile,
  speedOfLight,
}

class Speed extends DoubleProperty<SPEED> {
  ///Class for speed conversions, e.g. if you want to convert 1 meters per second in kilometers per hour:
  ///```dart
  ///var speed = Speed(removeTrailingZeros: false);
  ///speed.convert(SPEED.metersPerSecond, 1);
  ///print(speed.kilometersPerHour);
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
            SPEED.minutesPerMile: 'min/mi',
            SPEED.speedOfLight: 'c',
          },
          conversionTree:
              ConversionNode(name: SPEED.metersPerSecond, children: [
            ConversionNode(
              coefficientProduct: 299792458.0,
              name: SPEED.speedOfLight,
            ),
            ConversionNode(
                coefficientProduct: 1 / 3.6,
                name: SPEED.kilometersPerHour,
                children: [
                  ConversionNode(
                      coefficientProduct: 1.609344,
                      name: SPEED.milesPerHour,
                      children: [
                        ConversionNode(
                          conversionType: ConversionType.reciprocalConversion,
                          coefficientProduct: 60,
                          name: SPEED.minutesPerMile,
                        ),
                      ]),
                  ConversionNode(
                    coefficientProduct: 1.852,
                    name: SPEED.knots,
                  ),
                  ConversionNode(
                    conversionType: ConversionType.reciprocalConversion,
                    coefficientProduct: 60,
                    name: SPEED.minutesPerKilometer,
                  )
                ]),
            ConversionNode(
              coefficientProduct: 0.3048,
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
  Unit get minutesPerMile => getUnit(SPEED.minutesPerMile);
  Unit get speedOfLight => getUnit(SPEED.speedOfLight);
}
