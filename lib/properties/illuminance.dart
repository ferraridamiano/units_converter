import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/double_property.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';

enum ILLUMINANCE {
  lux,
  footCandle,
}

class Illuminance extends DoubleProperty<ILLUMINANCE> {
  ///Class for light conversions, e.g. if you want to convert 1 lux in to foot-candle:
  ///```dart
  ///const lux = 100;
  ///const fc = lux.convertFromTo(ILLUMINANCE.lux, ILLUMINANCE.footCandle);
  ///print(fc); // prints 9.290304
  /// ```
  Illuminance(
      {super.significantFigures,
        super.removeTrailingZeros,
        super.useScientificNotation,
        name})
      : super(
      name: name ?? PROPERTY.illuminance,
      mapSymbols: {
        ILLUMINANCE.lux: 'lx',
        ILLUMINANCE.footCandle: 'fc',
      },
      conversionTree: ConversionNode(name: ILLUMINANCE.lux, leafNodes: [
        ConversionNode(
          coefficientProduct: 10.763910416709722,
          name: ILLUMINANCE.footCandle,
        ),
      ]));

  Unit get lux => getUnit(ILLUMINANCE.lux);
  Unit get footCandle => getUnit(ILLUMINANCE.footCandle);
}
