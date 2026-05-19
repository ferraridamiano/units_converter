import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

abstract class RatioProperty<T extends Enum, N, D> extends Property<T, double> {
  /// Map between units and its symbol, must be of the same size of T
  Map<T, String?> mapSymbols;

  /// The number of significant figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  /// Whether to use the scientific notation (true) for [stringValue]s or
  /// decimal notation (false)
  bool useScientificNotation;

  final List<Unit> _unitList = [];
  late Map<T, Unit> _mapUnitsMap;
  Property numeratorProperty;
  Property denominatorProperty;

  RatioProperty(
      {required this.numeratorProperty,
      required this.denominatorProperty,
      required this.mapSymbols,
      name,
      this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true}) {
    size = mapSymbols.length;
    this.name = name;
    _mapUnitsMap = {};
    for (var unit in mapSymbols.keys) {
      final newUnit = Unit(unit, symbol: mapSymbols[unit]);
      newUnit.stringValueCallback = (val) => valueToString(
          val, significantFigures, removeTrailingZeros, useScientificNotation);
      _unitList.add(newUnit);
      _mapUnitsMap[unit] = newUnit;
    }
  }

  /// Converts a unit with a specific name (e.g. ANGLE.degree) and value to all
  /// other units
  @override
  void convert(dynamic name, double? value) {
    assert(name.runtimeType == T);

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
      _unitList[i].value =
          numeratorProperty.getUnit(_unitList[i].name.numerator).value! /
              denominatorProperty.getUnit(_unitList[i].name.denominator).value!;
    }
  }

  ///Returns all the units converted with prefixes
  @override
  List<Unit> getAll() => _unitList;

  ///Returns the Unit with the corresponding name
  @override
  Unit getUnit(T name) => _mapUnitsMap[name]!;
}
