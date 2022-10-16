import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

abstract class DoubleProperty<T> extends Property<T, double> {
  /// Defines the relation between the units of measurement of this property.
  /// E.g. in the following example we defined: `KiloDash = 1000 * Dash`,
  /// `DashPlus1 = Dash + 1` and `OneOver(DashPlus1) = 1 / (DashPlus1)`:
  /// ```dart
  /// ConversionNode conversionTree = ConversionNode(
  ///   name: 'Dash',
  ///   leafNodes: [
  ///     ConversionNode(
  ///       name: 'KiloDash',
  ///       coefficientProduct: 1000,
  ///     ),
  ///     ConversionNode(
  ///       name: 'DashPlus1',
  ///       coefficientSum: -1,
  ///       leafNodes: [
  ///         ConversionNode(
  ///           name: 'OneOver(DashPlus1)',
  ///           conversionType: ConversionType.reciprocalConversion,
  ///         ),
  ///       ],
  ///     ),
  ///   ],
  /// );
  /// ```
  ConversionNode<T> conversionTree;

  /// Map between units and its symbol
  Map<T, String>? mapSymbols;

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
  late List<ConversionNode> _nodeList;

  DoubleProperty(
      {required this.conversionTree,
      this.mapSymbols,
      name,
      this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true}) {
    conversionTree = conversionTree;
    this.name = name;
    _nodeList = conversionTree.getTreeAsList();
    size = _nodeList.length;
    for (var conversionNode in _nodeList) {
      _unitList.add(
          Unit(conversionNode.name, symbol: mapSymbols?[conversionNode.name]));
    }
  }

  /// Converts a unit with a specific name (e.g. ANGLE.degree) and value to all
  /// other units
  @override
  void convert(T name, double? value) {
    if (value == null) {
      for (Unit unit in _unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    conversionTree.convert(name, value);
    for (var i = 0; i < size; i++) {
      _unitList[i].value =
          _nodeList.singleWhere((node) => node.name == _unitList[i].name).value;
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
