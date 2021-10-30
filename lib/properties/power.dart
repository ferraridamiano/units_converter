import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

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
  /// Map between units and its symbol
  final Map<POWER, String> mapSymbols = {
    POWER.watt: 'W',
    POWER.milliwatt: 'mW',
    POWER.kilowatt: 'kW',
    POWER.megawatt: 'MW',
    POWER.gigawatt: 'GW',
    POWER.europeanHorsePower: 'hp(M)',
    POWER.imperialHorsePower: 'hp(I)',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for power conversions, e.g. if you want to convert 1 kilowatt in european horse power:
  ///```dart
  ///var power = Power(removeTrailingZeros: false);
  ///power.convert(Unit(POWER.kilowatt, value: 1));
  ///print(POWER.european_horse_power);
  /// ```
  Power({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: POWER.watt, leafNodes: [
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

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. POWER.european_horse_power) and value to all other units
  @override
  void convert(POWER name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get watt => getUnit(POWER.watt);
  Unit get milliwatt => getUnit(POWER.milliwatt);
  Unit get kilowatt => getUnit(POWER.kilowatt);
  Unit get megawatt => getUnit(POWER.megawatt);
  Unit get gigawatt => getUnit(POWER.gigawatt);
  Unit get europeanHorsePower => getUnit(POWER.europeanHorsePower);
  Unit get imperialHorsePower => getUnit(POWER.imperialHorsePower);
}
