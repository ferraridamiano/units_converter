import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available FUEL_CONSUMPTION units
enum FUEL_CONSUMPTION {
  kilometersPerLiter,
  litersPer100km,
  milesPerUsGallon,
  milesPerImperialGallon,
}

class FuelConsumption extends Property<FUEL_CONSUMPTION, double> {
  /// Map between units and its symbol
  final Map<FUEL_CONSUMPTION, String> mapSymbols = {
    FUEL_CONSUMPTION.kilometersPerLiter: 'km/l',
    FUEL_CONSUMPTION.litersPer100km: 'l/100km',
    FUEL_CONSUMPTION.milesPerUsGallon: 'mpg',
    FUEL_CONSUMPTION.milesPerImperialGallon: 'mpg',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for fuel_consumption conversions, e.g. if you want to convert 1 kilometers per liter in liters per 100 km:
  ///```dart
  ///var fuel_consumption = Fuel_Consumption(removeTrailingZeros: false);
  ///fuel_consumption.convert(Unit(FUEL_CONSUMPTION.kilometers_per_liter, value: 1));
  ///print(FUEL_CONSUMPTION.liters_per_100_km);
  /// ```
  FuelConsumption(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree =
        Node(name: FUEL_CONSUMPTION.kilometersPerLiter, leafNodes: [
      Node(
        conversionType: CONVERSION_TYPE.reciprocalConversion,
        coefficientProduct: 100.0,
        name: FUEL_CONSUMPTION.litersPer100km,
      ),
      Node(
        coefficientProduct: 0.4251437074,
        name: FUEL_CONSUMPTION.milesPerUsGallon,
      ),
      Node(
        coefficientProduct: 0.3540061899,
        name: FUEL_CONSUMPTION.milesPerImperialGallon,
      ),
    ]);

    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. FUEL_CONSUMPTION.liters_per_100_km) and value to all other units
  @override
  void convert(FUEL_CONSUMPTION name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get kilometersPerLiter => getUnit(FUEL_CONSUMPTION.kilometersPerLiter);
  Unit get litersPer100km => getUnit(FUEL_CONSUMPTION.litersPer100km);
  Unit get milesPerUsGallon => getUnit(FUEL_CONSUMPTION.milesPerUsGallon);
  Unit get milesPerImperialGallon =>
      getUnit(FUEL_CONSUMPTION.milesPerImperialGallon);
}
