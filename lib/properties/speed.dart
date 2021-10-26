import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
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

class Speed extends Property<SPEED, double> {
  //Map between units and its symbol
  final Map<SPEED, String> mapSymbols = {
    SPEED.metersPerSecond: 'm/s',
    SPEED.kilometersPerHour: 'km/h',
    SPEED.milesPerHour: 'mi/h',
    SPEED.knots: 'kts',
    SPEED.feetsPerSecond: 'ft/s',
    SPEED.minutesPerKilometer: 'min/km',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for speed conversions, e.g. if you want to convert 1 square meters in acres:
  ///```dart
  ///var speed = Speed(removeTrailingZeros: false);
  ///speed.convert(Unit(SPEED.square_meters, value: 1));
  ///print(SPEED.acres);
  /// ```
  Speed({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = SPEED.values.length;
    this.name = name ?? PROPERTY.speed;
    for (SPEED val in SPEED.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: SPEED.metersPerSecond, leafNodes: [
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
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. SPEED.miles_per_hour) and value to all other units
  @override
  void convert(SPEED name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < SPEED.values.length; i++) {
      unitList[i].value = getNodeByName(SPEED.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(
          unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get metersPerSecond => getUnit(SPEED.metersPerSecond);
  Unit get kilometersPerHour => getUnit(SPEED.kilometersPerHour);
  Unit get milesPerHour => getUnit(SPEED.milesPerHour);
  Unit get knots => getUnit(SPEED.knots);
  Unit get feetsPerSecond => getUnit(SPEED.feetsPerSecond);
  Unit get minutesPerKilometer => getUnit(SPEED.minutesPerKilometer);
}
