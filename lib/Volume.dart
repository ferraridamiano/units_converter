import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available VOLUME units
enum VOLUME {
  cubic_meters,
  liters,
  imperial_gallons,
  us_gallons,
  imperial_pints,
  us_pints,
  milliliters,
  tablespoons_us,
  australian_tablespoons,
  cups,
  cubic_centimeters,
  cubic_feet,
  cubic_inches,
  cubic_millimeters,
}

class Volume extends Property<VOLUME, double> {
  //Map between units and its symbol
  final Map<VOLUME, String> mapSymbols = {
    VOLUME.cubic_meters: 'm³',
    VOLUME.liters: 'l',
    VOLUME.imperial_gallons: 'imp gal',
    VOLUME.us_gallons: 'US gal',
    VOLUME.imperial_pints: 'imp pt',
    VOLUME.us_pints: 'US pt',
    VOLUME.milliliters: 'ml',
    VOLUME.tablespoons_us: 'tbsp.',
    VOLUME.australian_tablespoons: 'tbsp.',
    VOLUME.cups: 'cup',
    VOLUME.cubic_centimeters: 'cm³',
    VOLUME.cubic_feet: 'ft³',
    VOLUME.cubic_inches: 'in³',
    VOLUME.cubic_millimeters: 'mm³',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for volume conversions, e.g. if you want to convert 1 liter in US Gallons:
  ///```dart
  ///var volume = Volume(removeTrailingZeros: false);
  ///volume.convert(Unit(VOLUME.liters, value: 1));
  ///print(VOLUME.us_gallons);
  /// ```
  Volume({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = VOLUME.values.length;
    this.name = name ?? PROPERTY.VOLUME;
    VOLUME.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: VOLUME.cubic_meters, leafNodes: [
      Node(coefficientProduct: 1e-3, name: VOLUME.liters, leafNodes: [
        Node(
          coefficientProduct: 4.54609,
          name: VOLUME.imperial_gallons,
        ),
        Node(
          coefficientProduct: 3.785411784,
          name: VOLUME.us_gallons,
        ),
        Node(
          coefficientProduct: 0.56826125,
          name: VOLUME.imperial_pints,
        ),
        Node(
          coefficientProduct: 0.473176473,
          name: VOLUME.us_pints,
        ),
        Node(coefficientProduct: 1e-3, name: VOLUME.milliliters, leafNodes: [
          Node(
            coefficientProduct: 14.8,
            name: VOLUME.tablespoons_us,
          ),
          Node(
            coefficientProduct: 20.0,
            name: VOLUME.australian_tablespoons,
          ),
          Node(
            coefficientProduct: 240.0,
            name: VOLUME.cups,
          ),
        ]),
      ]),
      Node(coefficientProduct: 1e-6, name: VOLUME.cubic_centimeters, leafNodes: [
        Node(coefficientProduct: 16.387064, name: VOLUME.cubic_inches, leafNodes: [
          Node(
            coefficientProduct: 1728.0,
            name: VOLUME.cubic_feet,
          ),
        ]),
      ]),
      Node(
        coefficientProduct: 1e-9,
        name: VOLUME.cubic_millimeters,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. VOLUME.cubic_feet) and value to all other units
  @override
  void convert(VOLUME name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < VOLUME.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(VOLUME.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get cubic_meters => getUnit(VOLUME.cubic_meters);
  Unit get liters => getUnit(VOLUME.liters);
  Unit get imperial_gallons => getUnit(VOLUME.imperial_gallons);
  Unit get us_gallons => getUnit(VOLUME.us_gallons);
  Unit get imperial_pints => getUnit(VOLUME.imperial_pints);
  Unit get us_pints => getUnit(VOLUME.us_pints);
  Unit get milliliters => getUnit(VOLUME.milliliters);
  Unit get tablespoons_us => getUnit(VOLUME.tablespoons_us);
  Unit get australian_tablespoons => getUnit(VOLUME.australian_tablespoons);
  Unit get cups => getUnit(VOLUME.cups);
  Unit get cubic_centimeters => getUnit(VOLUME.cubic_centimeters);
  Unit get cubic_feet => getUnit(VOLUME.cubic_feet);
  Unit get cubic_inches => getUnit(VOLUME.cubic_inches);
  Unit get cubic_millimeters => getUnit(VOLUME.cubic_millimeters);
}
