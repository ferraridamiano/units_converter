import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

//Available POWER units
enum POWER {
  watt,
  milliwatt,
  kilowatt,
  megawatt,
  gigawatt,
  europeanHorsePower,
  imperialHorsePower,
}

class Power extends Property<POWER, double> {
  //Map between units and its symbol
  final Map<POWER, String> mapSymbols = {
    POWER.watt: 'W',
    POWER.milliwatt: 'mW',
    POWER.kilowatt: 'kW',
    POWER.megawatt: 'MW',
    POWER.gigawatt: 'GW',
    POWER.europeanHorsePower: 'hp(M)',
    POWER.imperialHorsePower: 'hp(I)',
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
    size = POWER.values.length;
    this.name = name ?? PROPERTY.power;
    for (POWER val in POWER.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: POWER.watt, leafNodes: [
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
        name: POWER.europeanHorsePower,
      ),
      Node(
        coefficientProduct: 745.69987158,
        name: POWER.imperialHorsePower,
      ),
    ]);
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. POWER.european_horse_power) and value to all other units
  @override
  void convert(POWER name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < POWER.values.length; i++) {
      unitList[i].value = getNodeByName(POWER.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(
          unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get watt => getUnit(POWER.watt);
  Unit get milliwatt => getUnit(POWER.milliwatt);
  Unit get kilowatt => getUnit(POWER.kilowatt);
  Unit get megawatt => getUnit(POWER.megawatt);
  Unit get gigawatt => getUnit(POWER.gigawatt);
  Unit get europeanHorsePower => getUnit(POWER.europeanHorsePower);
  Unit get imperialHorsePower => getUnit(POWER.imperialHorsePower);
}
