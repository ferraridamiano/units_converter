import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available TIME units
enum TIME {
  seconds,
  deciseconds,
  centiseconds,
  milliseconds,
  microseconds,
  nanoseconds,
  minutes,
  hours,
  days,
  weeks,
  years365,
  lustrum,
  decades,
  centuries,
  millennium,
}

class Time extends CustomConversion {
  ///Class for time conversions, e.g. if you want to convert 1 hour in seconds:
  ///```dart
  ///var time = Time(removeTrailingZeros: false);
  ///time.convert(Unit(TIME.hours, value: 1));
  ///print(TIME.seconds);
  /// ```
  Time(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.time,
          mapSymbols: {
            TIME.seconds: 's',
            TIME.deciseconds: 'ds',
            TIME.centiseconds: 'cs',
            TIME.milliseconds: 'ms',
            TIME.microseconds: 'µs',
            TIME.nanoseconds: 'ns',
            TIME.minutes: 'min',
            TIME.hours: 'h',
            TIME.days: 'd',
            TIME.weeks: null,
            TIME.years365: 'a',
            TIME.lustrum: null,
            TIME.decades: null,
            TIME.centuries: 'c.',
            TIME.millennium: null,
          },
          conversionTree: Node(name: TIME.seconds, leafNodes: [
            Node(
              coefficientProduct: 1e-1,
              name: TIME.deciseconds,
            ),
            Node(
              coefficientProduct: 1e-2,
              name: TIME.centiseconds,
            ),
            Node(
              coefficientProduct: 1e-3,
              name: TIME.milliseconds,
            ),
            Node(
              coefficientProduct: 1e-6,
              name: TIME.microseconds,
            ),
            Node(
              coefficientProduct: 1e-9,
              name: TIME.nanoseconds,
            ),
            Node(coefficientProduct: 60.0, name: TIME.minutes, leafNodes: [
              Node(coefficientProduct: 60.0, name: TIME.hours, leafNodes: [
                Node(coefficientProduct: 24.0, name: TIME.days, leafNodes: [
                  Node(
                    coefficientProduct: 7.0,
                    name: TIME.weeks,
                  ),
                  Node(
                      coefficientProduct: 365.0,
                      name: TIME.years365,
                      leafNodes: [
                        Node(
                          coefficientProduct: 5.0,
                          name: TIME.lustrum,
                        ),
                        Node(
                          coefficientProduct: 10.0,
                          name: TIME.decades,
                        ),
                        Node(
                          coefficientProduct: 100.0,
                          name: TIME.centuries,
                        ),
                        Node(
                          coefficientProduct: 1000.0,
                          name: TIME.millennium,
                        ),
                      ]),
                ]),
              ]),
            ]),
          ]),
        );

  Unit get seconds => getUnit(TIME.seconds);
  Unit get deciseconds => getUnit(TIME.deciseconds);
  Unit get centiseconds => getUnit(TIME.centiseconds);
  Unit get milliseconds => getUnit(TIME.milliseconds);
  Unit get microseconds => getUnit(TIME.microseconds);
  Unit get nanoseconds => getUnit(TIME.nanoseconds);
  Unit get minutes => getUnit(TIME.minutes);
  Unit get hours => getUnit(TIME.hours);
  Unit get days => getUnit(TIME.days);
  Unit get weeks => getUnit(TIME.weeks);
  Unit get years365 => getUnit(TIME.years365);
  Unit get lustrum => getUnit(TIME.lustrum);
  Unit get decades => getUnit(TIME.decades);
  Unit get centuries => getUnit(TIME.centuries);
  Unit get millennium => getUnit(TIME.millennium);
}
