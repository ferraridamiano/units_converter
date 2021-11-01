import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available FORCE units
enum FORCE {
  newton,
  dyne,
  poundForce,
  kilogramForce,
  poundal,
}

class Force extends Property<FORCE, double> {
  /// Map between units and its symbol
  final Map<FORCE, String> mapSymbols = {
    FORCE.newton: 'N',
    FORCE.dyne: 'dyn',
    FORCE.poundForce: 'lbf',
    FORCE.kilogramForce: 'kgf',
    FORCE.poundal: 'pdl',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for force conversions, e.g. if you want to convert 1 newton in pound force:
  ///```dart
  ///var force = Force(removeTrailingZeros: false);
  ///force.Convert(Unit(FORCE.newton, value: 1));
  ///print(FORCE.pound_force);
  /// ```
  Force({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: FORCE.newton, leafNodes: [
      Node(
        coefficientProduct: 1e-5,
        name: FORCE.dyne,
      ),
      Node(
        coefficientProduct: 4.4482216152605,
        name: FORCE.poundForce,
      ),
      Node(
        coefficientProduct: 9.80665,
        name: FORCE.kilogramForce,
      ),
      Node(
        coefficientProduct: 0.138254954376,
        name: FORCE.poundal,
      ),
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. FORCE.newton) and value to all other units
  @override
  void convert(FORCE name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get newton => getUnit(FORCE.newton);
  Unit get dyne => getUnit(FORCE.dyne);
  Unit get poundForce => getUnit(FORCE.poundForce);
  Unit get kilogramForce => getUnit(FORCE.kilogramForce);
  Unit get poundal => getUnit(FORCE.poundal);
}
