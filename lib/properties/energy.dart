import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available ENERGY units
enum ENERGY {
  joules,
  calories,
  kilowattHours,
  electronvolts,
  energyFootPound,
}

class Energy extends Property<ENERGY, double> {
  /// Map between units and its symbol
  static const Map<ENERGY, String?> mapSymbols = {
    ENERGY.joules: 'J',
    ENERGY.calories: 'cal',
    ENERGY.kilowattHours: 'kwh',
    ENERGY.electronvolts: 'eV',
    ENERGY.energyFootPound: 'ft⋅lbf',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for energy conversions, e.g. if you want to convert 1 joule in kilowatt hours:
  ///```dart
  ///var energy = Energy(removeTrailingZeros: false);
  ///energy.convert(Unit(ENERGY.joules, value: 1));
  ///print(ENERGY.kilowatt_hours);
  /// ```
  Energy(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: ENERGY.joules, leafNodes: [
      Node(
        coefficientProduct: 4.1867999409,
        name: ENERGY.calories,
      ),
      Node(
        coefficientProduct: 3600000.0,
        name: ENERGY.kilowattHours,
      ),
      Node(
        coefficientProduct: 1.60217646e-19,
        name: ENERGY.electronvolts,
      ),
      Node(
        coefficientProduct: 1 / 1.3558179483314004,
        name: ENERGY.energyFootPound,
      ),
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. ENERGY.calories) and value to all other units
  @override
  void convert(ENERGY name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get joules => getUnit(ENERGY.joules);
  Unit get calories => getUnit(ENERGY.calories);
  Unit get kilowattHours => getUnit(ENERGY.kilowattHours);
  Unit get electronvolts => getUnit(ENERGY.electronvolts);
  Unit get energyFootPound => getUnit(ENERGY.energyFootPound);
}
