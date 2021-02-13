import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available POWER units
enum POWER {
  watt,
  milliwatt,
  kilowatt,
  megawatt,
  gigawatt,
  european_horse_power,
  imperial_horse_power,
}

class Power extends Property<POWER, double> {
  //Map between units and its symbol
  final Map<POWER, String> mapSymbols = {
    POWER.watt: 'W',
    POWER.milliwatt: 'mW',
    POWER.kilowatt: 'kW',
    POWER.megawatt: 'MW',
    POWER.gigawatt: 'GW',
    POWER.european_horse_power: 'hp(M)',
    POWER.imperial_horse_power: 'hp(I)',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for power conversions, e.g. if you want to convert 1 kilowatt in european horse power:
  ///```dart
  ///var power = Power(removeTrailingZeros: false);
  ///power.convert(Unit(POWER.kilowatt, value: 1));
  ///print(POWER.european_horse_power);
  /// ```
  Power({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    this.name = name ?? PROPERTY.POWER;
    POWER.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: POWER.watt, leafNodes: [
      Node(
        coefficientProduct: 1e-3,
        name: POWER.milliwatt,
      ),
      Node(
        coefficientProduct: 1e3,
        name: POWER.kilowatt,
      ),
      Node(
        coefficientProduct: 1e6,
        name: POWER.megawatt,
      ),
      Node(
        coefficientProduct: 1e9,
        name: POWER.gigawatt,
      ),
      Node(
        coefficientProduct: 735.49875,
        name: POWER.european_horse_power,
      ),
      Node(
        coefficientProduct: 745.69987158,
        name: POWER.imperial_horse_power,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. POWER.european_horse_power) and value to all other units
  @override
  void convert(POWER name, double value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < POWER.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(POWER.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

  Unit get watt => getUnit(POWER.watt);
  Unit get milliwatt => getUnit(POWER.milliwatt);
  Unit get kilowatt => getUnit(POWER.kilowatt);
  Unit get megawatt => getUnit(POWER.megawatt);
  Unit get gigawatt => getUnit(POWER.gigawatt);
  Unit get european_horse_power => getUnit(POWER.european_horse_power);
  Unit get imperial_horse_power => getUnit(POWER.imperial_horse_power);
}
