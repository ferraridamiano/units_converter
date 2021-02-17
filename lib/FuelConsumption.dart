import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available FUEL_CONSUMPTION units
enum FUEL_CONSUMPTION {
  kilometers_per_liter,
  liters_per_100_km,
  miles_per_US_gallon,
  miles_per_imperial_gallon,
}

class FuelConsumption extends Property<FUEL_CONSUMPTION, double> {
  //Map between units and its symbol
  final Map<FUEL_CONSUMPTION, String> mapSymbols = {
    FUEL_CONSUMPTION.kilometers_per_liter: 'km/l',
    FUEL_CONSUMPTION.liters_per_100_km: 'l/100km',
    FUEL_CONSUMPTION.miles_per_US_gallon: 'mpg',
    FUEL_CONSUMPTION.miles_per_imperial_gallon: 'mpg',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for fuel_consumption conversions, e.g. if you want to convert 1 kilometers per liter in liters per 100 km:
  ///```dart
  ///var fuel_consumption = Fuel_Consumption(removeTrailingZeros: false);
  ///fuel_consumption.convert(Unit(FUEL_CONSUMPTION.kilometers_per_liter, value: 1));
  ///print(FUEL_CONSUMPTION.liters_per_100_km);
  /// ```
  FuelConsumption({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    this.name = name ?? PROPERTY.FUEL_CONSUMPTION;
    FUEL_CONSUMPTION.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: FUEL_CONSUMPTION.kilometers_per_liter, leafNodes: [
      Node(
        conversionType: RECIPROCAL_CONVERSION,
        coefficientProduct: 100.0,
        name: FUEL_CONSUMPTION.liters_per_100_km,
      ),
      Node(
        coefficientProduct: 0.4251437074,
        name: FUEL_CONSUMPTION.miles_per_US_gallon,
      ),
      Node(
        coefficientProduct: 0.3540061899,
        name: FUEL_CONSUMPTION.miles_per_imperial_gallon,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. FUEL_CONSUMPTION.liters_per_100_km) and value to all other units
  @override
  void convert(FUEL_CONSUMPTION name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < FUEL_CONSUMPTION.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(FUEL_CONSUMPTION.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get kilometers_per_liter => getUnit(FUEL_CONSUMPTION.kilometers_per_liter);
  Unit get liters_per_100_km => getUnit(FUEL_CONSUMPTION.liters_per_100_km);
  Unit get miles_per_US_gallon => getUnit(FUEL_CONSUMPTION.miles_per_US_gallon);
  Unit get miles_per_imperial_gallon => getUnit(FUEL_CONSUMPTION.miles_per_imperial_gallon);
}
