import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available ENERGY units
enum ENERGY {
  joules,
  calories,
  kilowatt_hours,
  electronvolts,
}

class Energy extends Property<ENERGY, double> {
  //Map between units and its symbol
  final Map<ENERGY, String> mapSymbols = {
    ENERGY.joules: 'J',
    ENERGY.calories: 'cal',
    ENERGY.kilowatt_hours: 'kwh',
    ENERGY.electronvolts: 'eV',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for energy conversions, e.g. if you want to convert 1 joule in kilowatt hours:
  ///```dart
  ///var energy = Energy(removeTrailingZeros: false);
  ///energy.convert(Unit(ENERGY.joules, value: 1));
  ///print(ENERGY.kilowatt_hours);
  /// ```
  Energy({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = ENERGY.values.length;
    this.name = name ?? PROPERTY.ENERGY;
    ENERGY.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: ENERGY.joules, leafNodes: [
      Node(
        coefficientProduct: 4.1867999409,
        name: ENERGY.calories,
      ),
      Node(
        coefficientProduct: 3600000.0,
        name: ENERGY.kilowatt_hours,
      ),
      Node(
        coefficientProduct: 1.60217646e-19,
        name: ENERGY.electronvolts,
      ),
    ]);
  }

  ///Converts a unit with a specific name (e.g. ENERGY.calories) and value to all other units
  @override
  void convert(ENERGY name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < ENERGY.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(ENERGY.values.elementAt(i))?.value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get joules => getUnit(ENERGY.joules);
  Unit get calories => getUnit(ENERGY.calories);
  Unit get kilowatt_hours => getUnit(ENERGY.kilowatt_hours);
  Unit get electronvolts => getUnit(ENERGY.electronvolts);
}
