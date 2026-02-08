import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

/// Available force units
enum FORCE {
  newton,
  dyne,
  poundForce,
  kilogramForce,
  poundal,
}

class Force extends DoubleProperty<FORCE> {
  ///Class for force conversions, e.g. if you want to convert 1 newton in pound force:
  ///```dart
  ///var force = Force(removeTrailingZeros: false);
  ///force.Convert(FORCE.newton, 1);
  ///print(FORCE.pound_force);
  /// ```
  Force(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
            name: name ?? PROPERTY.force,
            mapSymbols: {
              FORCE.newton: 'N',
              FORCE.dyne: 'dyn',
              FORCE.poundForce: 'lbf',
              FORCE.kilogramForce: 'kgf',
              FORCE.poundal: 'pdl',
            },
            conversionTree: ConversionNode(name: FORCE.newton, children: [
              ConversionNode(
                coefficientProduct: 1e-5,
                name: FORCE.dyne,
              ),
              ConversionNode(
                coefficientProduct: 4.4482216152605,
                name: FORCE.poundForce,
              ),
              ConversionNode(
                coefficientProduct: 9.80665,
                name: FORCE.kilogramForce,
              ),
              ConversionNode(
                coefficientProduct: 0.138254954376,
                name: FORCE.poundal,
              ),
            ]));

  Unit get newton => getUnit(FORCE.newton);
  Unit get dyne => getUnit(FORCE.dyne);
  Unit get poundForce => getUnit(FORCE.poundForce);
  Unit get kilogramForce => getUnit(FORCE.kilogramForce);
  Unit get poundal => getUnit(FORCE.poundal);
}
