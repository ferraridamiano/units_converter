import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

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

class Time extends Property<TIME, double> {
  //Map between units and its symbol
  final Map<TIME, String> mapSymbols = {
    TIME.seconds: 's',
    TIME.deciseconds: 'ds',
    TIME.centiseconds: 'cs',
    TIME.milliseconds: 'ms',
    TIME.microseconds: 'µs',
    TIME.nanoseconds: 'ns',
    TIME.minutes: 'min',
    TIME.hours: 'h',
    TIME.days: 'd',
    TIME.years365: 'a',
    TIME.centuries: 'c.',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for time conversions, e.g. if you want to convert 1 hour in seconds:
  ///```dart
  ///var time = Time(removeTrailingZeros: false);
  ///time.convert(Unit(TIME.hours, value: 1));
  ///print(TIME.seconds);
  /// ```
  Time({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = TIME.values.length;
    this.name = name ?? PROPERTY.time;
    for (TIME val in TIME.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: TIME.seconds, leafNodes: [
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
            Node(coefficientProduct: 365.0, name: TIME.years365, leafNodes: [
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
    ]);
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. TIME.days) and value to all other units
  @override
  void convert(TIME name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < TIME.values.length; i++) {
      unitList[i].value = getNodeByName(TIME.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(
          unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

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
