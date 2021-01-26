import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

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
  years_365,
  lustra,
  decades,
  centuries,
  millennia,
}

class Time extends Property<TIME, double> {
  //Map between units and its symbol
  final Map<TIME, String> mapSymbols = {
    TIME.seconds: 'm²',
    TIME.deciseconds: 'cm²',
    TIME.centiseconds: 'in²',
    TIME.milliseconds: 'ft²',
    TIME.microseconds: 'mi²',
    TIME.nanoseconds: 'yd²',
    TIME.minutes: 'mm²',
    TIME.hours: 'km²',
    TIME.days: 'he',
    TIME.weeks: 'ac',
    TIME.years_365: 'a',
    TIME.lustra: 'km²',
    TIME.decades: 'he',
    TIME.centuries: 'ac',
    TIME.millennia: 'a',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for time conversions, e.g. if you want to convert 1 hour in seconds:
  ///```dart
  ///var time = Time(removeTrailingZeros: false);
  ///time.Convert(Unit(TIME.hours, value: 1));
  ///print(TIME.seconds);
  /// ```
  Time({this.significantFigures = 10, this.removeTrailingZeros = true}) {
    TIME.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name:  TIME.seconds,
        leafNodes: [
          Node(coefficientProduct: 1e-1, name: TIME.deciseconds,),
          Node(coefficientProduct: 1e-2, name: TIME.centiseconds,),
          Node(coefficientProduct: 1e-3, name: TIME.milliseconds,),
          Node(coefficientProduct: 1e-6, name: TIME.microseconds,),
          Node(coefficientProduct: 1e-9, name: TIME.nanoseconds,),
          Node(coefficientProduct: 60.0, name: TIME.minutes,leafNodes: [
            Node(coefficientProduct: 60.0, name: TIME.hours,leafNodes: [
              Node(coefficientProduct: 24.0, name: TIME.days,leafNodes: [
                Node(coefficientProduct: 7.0, name: TIME.weeks,),
                Node(coefficientProduct: 365.0, name: TIME.years_365,leafNodes: [
                  Node(coefficientProduct: 5.0, name: TIME.lustra,),
                  Node(coefficientProduct: 10.0, name: TIME.decades,),
                  Node(coefficientProduct: 100.0, name: TIME.centuries,),
                  Node(coefficientProduct: 1000.0, name: TIME.millennia,),
                ]),
              ]),
            ]),
          ]),
        ]);
  }

  ///Converts a unit with a specific name (e.g. TIME.days) and value to all other units
  @override
  void convert(TIME name, double value) {
    super.convert(name, value);
    for (var i = 0; i < TIME.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(TIME.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get seconds => _getUnit(TIME.seconds);
  Unit get deciseconds => _getUnit(TIME.deciseconds);
  Unit get centiseconds => _getUnit(TIME.centiseconds);
  Unit get milliseconds => _getUnit(TIME.milliseconds);
  Unit get microseconds => _getUnit(TIME.microseconds);
  Unit get nanoseconds => _getUnit(TIME.nanoseconds);
  Unit get minutes => _getUnit(TIME.minutes);
  Unit get hours => _getUnit(TIME.hours);
  Unit get days => _getUnit(TIME.days);
  Unit get weeks => _getUnit(TIME.weeks);
  Unit get years_365 => _getUnit(TIME.years_365);
  Unit get lustra => _getUnit(TIME.lustra);
  Unit get decades => _getUnit(TIME.decades);
  Unit get centuries => _getUnit(TIME.centuries);
  Unit get millennia => _getUnit(TIME.millennia);

  ///Returns the Unit with the corresponding name
  Unit _getUnit(var name) {
    return unitList.where((element) => element.name == name).first;
  }
}
