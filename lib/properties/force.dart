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

class Force extends CustomConversion {
  ///Class for force conversions, e.g. if you want to convert 1 newton in pound force:
  ///```dart
  ///var force = Force(removeTrailingZeros: false);
  ///force.Convert(Unit(FORCE.newton, value: 1));
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
            conversionTree: Node(name: FORCE.newton, leafNodes: [
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
            ]));

  Unit get newton => getUnit(FORCE.newton);
  Unit get dyne => getUnit(FORCE.dyne);
  Unit get poundForce => getUnit(FORCE.poundForce);
  Unit get kilogramForce => getUnit(FORCE.kilogramForce);
  Unit get poundal => getUnit(FORCE.poundal);
}
