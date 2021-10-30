import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available SPEED units
enum SPEED {
  metersPerSecond,
  kilometersPerHour,
  milesPerHour,
  knots,
  feetsPerSecond,
  minutesPerKilometer,
}

class Speed extends Property<SPEED, double> {
  /// Map between units and its symbol
  final Map<SPEED, String> mapSymbols = {
    SPEED.metersPerSecond: 'm/s',
    SPEED.kilometersPerHour: 'km/h',
    SPEED.milesPerHour: 'mi/h',
    SPEED.knots: 'kts',
    SPEED.feetsPerSecond: 'ft/s',
    SPEED.minutesPerKilometer: 'min/km',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for speed conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var speed = Speed(removeTrailingZeros: false);
  ///speed.convert(Unit(SPEED.square_meters, value: 1));
  ///print(SPEED.acres);
  /// ```
  Speed({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: SPEED.metersPerSecond, leafNodes: [
      Node(
          coefficientProduct: 1 / 3.6,
          name: SPEED.kilometersPerHour,
          leafNodes: [
            Node(
              coefficientProduct: 1.609344,
              name: SPEED.milesPerHour,
            ),
            Node(
              coefficientProduct: 1.852,
              name: SPEED.knots,
            ),
            Node(
              conversionType: CONVERSION_TYPE.reciprocalConversion,
              coefficientProduct: 60,
              name: SPEED.minutesPerKilometer,
            )
          ]),
      Node(
        coefficientProduct: 0.3048,
        name: SPEED.feetsPerSecond,
      ),
    ]);
    
    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. SPEED.miles_per_hour) and value to all other units
  @override
  void convert(SPEED name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get metersPerSecond => getUnit(SPEED.metersPerSecond);
  Unit get kilometersPerHour => getUnit(SPEED.kilometersPerHour);
  Unit get milesPerHour => getUnit(SPEED.milesPerHour);
  Unit get knots => getUnit(SPEED.knots);
  Unit get feetsPerSecond => getUnit(SPEED.feetsPerSecond);
  Unit get minutesPerKilometer => getUnit(SPEED.minutesPerKilometer);
}
