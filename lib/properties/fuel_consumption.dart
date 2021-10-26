import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

//Available FUEL_CONSUMPTION units
enum FUEL_CONSUMPTION {
  kilometersPerLiter,
  litersPer100km,
  milesPerUsGallon,
  milesPerImperialGallon,
}

class FuelConsumption extends Property<FUEL_CONSUMPTION, double> {
  //Map between units and its symbol
  final Map<FUEL_CONSUMPTION, String> mapSymbols = {
    FUEL_CONSUMPTION.kilometersPerLiter: 'km/l',
    FUEL_CONSUMPTION.litersPer100km: 'l/100km',
    FUEL_CONSUMPTION.milesPerUsGallon: 'mpg',
    FUEL_CONSUMPTION.milesPerImperialGallon: 'mpg',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for fuel_consumption conversions, e.g. if you want to convert 1 kilometers per liter in liters per 100 km:
  ///```dart
  ///var fuel_consumption = Fuel_Consumption(removeTrailingZeros: false);
  ///fuel_consumption.convert(Unit(FUEL_CONSUMPTION.kilometers_per_liter, value: 1));
  ///print(FUEL_CONSUMPTION.liters_per_100_km);
  /// ```
  FuelConsumption(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = FUEL_CONSUMPTION.values.length;
    this.name = name ?? PROPERTY.fuelConsumption;
    for (FUEL_CONSUMPTION val in FUEL_CONSUMPTION.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion =
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
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. FUEL_CONSUMPTION.liters_per_100_km) and value to all other units
  @override
  void convert(FUEL_CONSUMPTION name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < FUEL_CONSUMPTION.values.length; i++) {
      unitList[i].value =
          getNodeByName(FUEL_CONSUMPTION.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(
          unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get kilometersPerLiter => getUnit(FUEL_CONSUMPTION.kilometersPerLiter);
  Unit get litersPer100km => getUnit(FUEL_CONSUMPTION.litersPer100km);
  Unit get milesPerUsGallon => getUnit(FUEL_CONSUMPTION.milesPerUsGallon);
  Unit get milesPerImperialGallon =>
      getUnit(FUEL_CONSUMPTION.milesPerImperialGallon);
}
