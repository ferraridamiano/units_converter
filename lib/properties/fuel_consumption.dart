import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available FUEL_CONSUMPTION units
// ignore: camel_case_types
enum FUEL_CONSUMPTION {
  kilometersPerLiter,
  litersPer100km,
  milesPerUsGallon,
  milesPerImperialGallon,
}

class FuelConsumption extends CustomProperty {
  ///Class for fuel_consumption conversions, e.g. if you want to convert 1 kilometers per liter in liters per 100 km:
  ///```dart
  ///var fuel_consumption = Fuel_Consumption(removeTrailingZeros: false);
  ///fuel_consumption.convert(Unit(FUEL_CONSUMPTION.kilometers_per_liter, value: 1));
  ///print(FUEL_CONSUMPTION.liters_per_100_km);
  /// ```
  FuelConsumption(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
            name: name ?? PROPERTY.fuelConsumption,
            mapSymbols: {
              FUEL_CONSUMPTION.kilometersPerLiter: 'km/l',
              FUEL_CONSUMPTION.litersPer100km: 'l/100km',
              FUEL_CONSUMPTION.milesPerUsGallon: 'mpg',
              FUEL_CONSUMPTION.milesPerImperialGallon: 'mpg',
            },
            conversionTree: ConversionNode(
                name: FUEL_CONSUMPTION.kilometersPerLiter,
                leafNodes: [
                  ConversionNode(
                    conversionType: ConversionType.reciprocalConversion,
                    coefficientProduct: Rational.fromInt(100),
                    name: FUEL_CONSUMPTION.litersPer100km,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.parse('0.4251437074'),
                    name: FUEL_CONSUMPTION.milesPerUsGallon,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.parse('0.3540061899'),
                    name: FUEL_CONSUMPTION.milesPerImperialGallon,
                  ),
                ]));

  Unit get kilometersPerLiter => getUnit(FUEL_CONSUMPTION.kilometersPerLiter);
  Unit get litersPer100km => getUnit(FUEL_CONSUMPTION.litersPer100km);
  Unit get milesPerUsGallon => getUnit(FUEL_CONSUMPTION.milesPerUsGallon);
  Unit get milesPerImperialGallon =>
      getUnit(FUEL_CONSUMPTION.milesPerImperialGallon);
}
