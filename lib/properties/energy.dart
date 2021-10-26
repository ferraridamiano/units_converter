import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

//Available ENERGY units
enum ENERGY {
  joules,
  calories,
  kilowattHours,
  electronvolts,
  energyFootPound,
}

class Energy extends Property<ENERGY, double> {
  //Map between units and its symbol
  final Map<ENERGY, String> mapSymbols = {
    ENERGY.joules: 'J',
    ENERGY.calories: 'cal',
    ENERGY.kilowattHours: 'kwh',
    ENERGY.electronvolts: 'eV',
    ENERGY.energyFootPound: 'ft⋅lbf',
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for energy conversions, e.g. if you want to convert 1 joule in kilowatt hours:
  ///```dart
  ///var energy = Energy(removeTrailingZeros: false);
  ///energy.convert(Unit(ENERGY.joules, value: 1));
  ///print(ENERGY.kilowatt_hours);
  /// ```
  Energy(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    size = ENERGY.values.length;
    this.name = name ?? PROPERTY.energy;
    for (ENERGY val in ENERGY.values) {
      unitList.add(Unit(val, symbol: mapSymbols[val]));
    }
    unitConversion = Node(name: ENERGY.joules, leafNodes: [
      Node(
        coefficientProduct: 4.1867999409,
        name: ENERGY.calories,
      ),
      Node(
        coefficientProduct: 3600000.0,
        name: ENERGY.kilowattHours,
      ),
      Node(
        coefficientProduct: 1.60217646e-19,
        name: ENERGY.electronvolts,
      ),
      Node(
        coefficientProduct: 1 / 1.3558179483314004,
        name: ENERGY.energyFootPound,
      ),
    ]);
    nodeList = unitConversion.getTreeAsList();
  }

  ///Converts a unit with a specific name (e.g. ENERGY.calories) and value to all other units
  @override
  void convert(ENERGY name, double? value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < ENERGY.values.length; i++) {
      unitList[i].value = getNodeByName(ENERGY.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(
          unitList[i].value!, significantFigures, removeTrailingZeros);
    }
  }

  Unit get joules => getUnit(ENERGY.joules);
  Unit get calories => getUnit(ENERGY.calories);
  Unit get kilowattHours => getUnit(ENERGY.kilowattHours);
  Unit get electronvolts => getUnit(ENERGY.electronvolts);
  Unit get energyFootPound => getUnit(ENERGY.energyFootPound);
}
