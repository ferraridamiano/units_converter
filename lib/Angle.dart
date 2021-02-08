import 'package:units_converter/Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available ANGLE units
enum ANGLE {
  degree,
  minutes,
  seconds,
  radians,
}

class Angle extends Property<ANGLE, double> {
  //Map between units and its symbol
  final Map<ANGLE, String> mapSymbols = {
    ANGLE.degree: '°',
    ANGLE.minutes: "'",
    ANGLE.seconds: "''",
    ANGLE.radians: 'rad',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for angle conversions, e.g. if you want to convert 1 radiant in degree:
  ///```dart
  ///var angle = Angle(removeTrailingZeros: false);
  ///angle.Convert(Unit(ANGLE.radians, value: 1));
  ///print(ANGLE.degree);
  /// ```
  Angle({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    this.name = name ?? PROPERTY.ANGLE;
    ANGLE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: ANGLE.degree, leafNodes: [
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
  }

  ///Converts a unit with a specific name (e.g. ANGLE.degree) and value to all other units
  @override
  void convert(ANGLE name, double value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < ANGLE.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(ANGLE.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get degree => getUnit(ANGLE.degree);
  Unit get minutes => getUnit(ANGLE.minutes);
  Unit get seconds => getUnit(ANGLE.seconds);
  Unit get radians => getUnit(ANGLE.radians);

}
