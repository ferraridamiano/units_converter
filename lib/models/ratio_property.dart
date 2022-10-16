import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

abstract class RatioProperty<T, N, D> extends Property<T, double> {
  /// Map between units and its symbol
  Map<T, String> mapSymbols;

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  /// Whether to use the scientific notation (true) for [stringValue]s or
  /// decimal notation (false)
  bool useScientificNotation;

  final List<Unit> _unitList = [];
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
    this.name = name;
    size = mapSymbols.length;
    // TODO try to fix the following line
    assert(size == mapSymbols.length);
    for (var unit in mapSymbols.keys) {
      _unitList.add(Unit(unit, symbol: mapSymbols[unit]));
    }
    /*for (var conversionNode in _nodeList) {
      _unitList.add(
          Unit(conversionNode.name, symbol: mapSymbols?[conversionNode.name]));
    }*/
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
      _unitList[i].stringValue = valueToString(_unitList[i].value!,
          significantFigures, removeTrailingZeros, useScientificNotation);
    }
  }

  ///Returns all the units converted with prefixes
  @override
  List<Unit> getAll() => _unitList;

  ///Returns the Unit with the corresponding name
  @override
  Unit getUnit(T name) =>
      _unitList.where((element) => element.name == name).single;
}
