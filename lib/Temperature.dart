import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available TEMPERATURE units
enum TEMPERATURE {
  fahrenheit,
  celsius,
  kelvin,
  reamur,
  romer,
  delisle,
  rankine,
}

class Temperature extends Property<TEMPERATURE, double> {
  //Map between units and its symbol
  final Map<TEMPERATURE, String> mapSymbols = {
    TEMPERATURE.fahrenheit: '°F',
    TEMPERATURE.celsius: '°C',
    TEMPERATURE.kelvin: 'K',
    TEMPERATURE.reamur: '°Re',
    TEMPERATURE.romer: '°Rø',
    TEMPERATURE.delisle: '°De',
    TEMPERATURE.rankine: '°R',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for temperature conversions, e.g. if you want to convert 1 celsius in kelvin:
  ///```dart
  ///var temperature = Temperature(removeTrailingZeros: false);
  ///temperature.convert(Unit(TEMPERATURE.celsius, value: 1));
  ///print(TEMPERATURE.kelvin);
  /// ```
  Temperature({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    this.name = name ?? PROPERTY.TEMPERATURE;
    TEMPERATURE.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: TEMPERATURE.fahrenheit, leafNodes: [
      Node(coefficientProduct: 1.8, coefficientSum: 32.0, name: TEMPERATURE.celsius, leafNodes: [
        Node(
          coefficientSum: -273.15,
          name: TEMPERATURE.kelvin,
        ),
        Node(
          coefficientProduct: 5 / 4,
          name: TEMPERATURE.reamur,
        ),
        Node(
          coefficientProduct: 40 / 21,
          coefficientSum: -100 / 7,
          name: TEMPERATURE.romer,
        ),
        Node(
          coefficientProduct: -2 / 3,
          coefficientSum: 100,
          name: TEMPERATURE.delisle,
        ),
      ]),
      Node(
        coefficientSum: -459.67,
        name: TEMPERATURE.rankine,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. TEMPERATURE.kelvin) and value to all other units
  @override
  void convert(TEMPERATURE name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < TEMPERATURE.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(TEMPERATURE.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get fahrenheit => getUnit(TEMPERATURE.fahrenheit);
  Unit get celsius => getUnit(TEMPERATURE.celsius);
  Unit get kelvin => getUnit(TEMPERATURE.kelvin);
  Unit get reamur => getUnit(TEMPERATURE.reamur);
  Unit get romer => getUnit(TEMPERATURE.romer);
  Unit get delisle => getUnit(TEMPERATURE.delisle);
  Unit get rankine => getUnit(TEMPERATURE.rankine);
}
