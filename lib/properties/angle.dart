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

class Angle extends Property<ANGLE, double> {
  /// Map between units and its symbol
  final Map<ANGLE, String> mapSymbols = {
    ANGLE.degree: '°',
    ANGLE.minutes: "'",
    ANGLE.seconds: "''",
    ANGLE.radians: 'rad',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for angle conversions, e.g. if you want to convert 1 radiant in degree:
  ///```dart
  ///var angle = Angle(removeTrailingZeros: false);
  ///angle.convert(Unit(ANGLE.radians, value: 1));
  ///print(ANGLE.degree);
  /// ```
  Angle({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: ANGLE.degree, leafNodes: [
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
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  /// Converts a unit with a specific name (e.g. ANGLE.degree) and value to all
  /// other units
  @override
  void convert(ANGLE name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get degree => getUnit(ANGLE.degree);
  Unit get minutes => getUnit(ANGLE.minutes);
  Unit get seconds => getUnit(ANGLE.seconds);
  Unit get radians => getUnit(ANGLE.radians);
}
