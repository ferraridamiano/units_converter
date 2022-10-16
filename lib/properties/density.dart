import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/properties/mass.dart';
import 'package:units_converter/properties/volume.dart';
import 'package:units_converter/utils/utils.dart';

enum DENSITY {
  gramsPerLiter(MASS.grams, VOLUME.liters),
  gramsPerCubicCentimeter(MASS.grams, VOLUME.cubicCentimeters),
  kilogramsPerLiter(MASS.kilograms, VOLUME.liters),
  kilogramsPerCubicMeter(MASS.kilograms, VOLUME.cubicMeters);

  final MASS numerator;
  final VOLUME denominator;
  const DENSITY(this.numerator, this.denominator);
}

class Density extends Property<DENSITY, double> {
  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  /// Whether to use the scientific notation (true) for [stringValue]s or
  /// decimal notation (false)
  bool useScientificNotation;

  //Map between units and its symbol
  static const Map<DENSITY, String> mapSymbols = {
    DENSITY.gramsPerLiter: 'g/l',
    DENSITY.gramsPerCubicCentimeter: 'g/cm³',
    DENSITY.kilogramsPerLiter: 'kg/l',
    DENSITY.kilogramsPerCubicMeter: 'kg/m³',
  };

  final List<Unit> _unitList = [];

  Property numeratorProperty =
      getPropertyFromEnum(DENSITY.values[0].numerator)!;
  Property denominatorProperty =
      getPropertyFromEnum(DENSITY.values[0].denominator)!;

  ///Class for density conversions, e.g. if you want to convert 1 gram per liter
  ///in kilograms per liter:
  ///```dart
  ///var density = Density(removeTrailingZeros: false);
  ///density.convert(Unit(DENSITY.gramsPerLiter, value: 1));
  ///print(DENSITY.kilogramsPerLiter);
  /// ```
  Density(
      {name,
      this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true}) {
    this.name = name;
    size = DENSITY.values.length;
    for (var density in DENSITY.values) {
      _unitList.add(Unit(density, symbol: mapSymbols[density]));
    }
  }

  /// Converts a unit with a specific name (e.g. ANGLE.degree) and value to all
  /// other units
  @override
  void convert(DENSITY name, double? value) {
    if (value == null) {
      for (Unit unit in _unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }

    numeratorProperty.convert(name.numerator, value);
    denominatorProperty.convert(name.denominator, 1.0);

    for (var i = 0; i < size; i++) {
      DENSITY unit = _unitList[i].name;
      _unitList[i].value = numeratorProperty.getUnit(unit.numerator).value! /
          denominatorProperty.getUnit(unit.denominator).value!;
      _unitList[i].stringValue = valueToString(_unitList[i].value!,
          significantFigures, removeTrailingZeros, useScientificNotation);
    }
  }

  ///Returns all the units converted with prefixes
  @override
  List<Unit> getAll() => _unitList;

  ///Returns the Unit with the corresponding name
  @override
  Unit getUnit(DENSITY name) =>
      _unitList.where((element) => element.name == name).single;

  Unit get gramsPerLiter => getUnit(DENSITY.gramsPerLiter);
  Unit get gramsPerCubicCentimeter => getUnit(DENSITY.gramsPerCubicCentimeter);
  Unit get kilogramsPerLiter => getUnit(DENSITY.gramsPerCubicCentimeter);
  Unit get kilogramsPerCubicMeter => getUnit(DENSITY.kilogramsPerCubicMeter);
}
