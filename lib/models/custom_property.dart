import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

class CustomProperty extends Property<dynamic, double> {
  //Map between units and its symbol
  Map<dynamic, String>? mapSymbols;

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
  ConversionNode conversionTree;

  ///Class for custom conversions. E.g.:
  ///```dart
  ///ConversionNode conversionTree = ConversionNode(
  ///  name: 'Dash',    // base unit
  ///  leafNodes: [
  ///    ConversionNode(
  ///      name: 'KiloDash',
  ///      coefficientProduct: 1000, // 1 k=KiloDash is 1000 Dash
  ///    ),
  ///    ConversionNode(
  ///      name: 'DashPlus1',
  ///      coefficientSum: -1,
  ///      leafNodes: [
  ///        ConversionNode(
  ///          name: 'OneOver(DashPlus1)',
  ///          conversionType: ConversionType.reciprocalConversion,
  ///        ),
  ///      ],
  ///    ),
  ///  ],
  ///);
  ///// Symbols of each unit. Must be initialized (even with each value to null)
  ///final Map<String, String?> symbolsMap = {
  ///  'Dash': 'dsh',
  ///  'KiloDash': 'kdsh',
  ///  'DashPlus1': 'dsh+1',
  ///  'OneOver(DashPlus1)': null,
  ///};
  ///
  ///var dash = CustomProperty(
  ///  conversionTree: conversionTree,
  ///  mapSymbols: symbolsMap,
  ///  name: 'Conversion of Dash',
  ///);
  ///
  ///dash.convert('Dash', 1);
  ///var myUnits = dash.getAll();
  ///for (var unit in myUnits) {
  ///  print(
  ///      'name:${unit.name}, value:${unit.value}, stringValue:${unit.stringValue}, symbol:${unit.symbol}');
  ///}
  /// ```
  CustomProperty(
      {required this.conversionTree,
      this.mapSymbols,
      name,
      this.significantFigures = 10,
      this.removeTrailingZeros = true,
      this.useScientificNotation = true}) {
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
  void convert(var name, double? value) => _convert(name, value);

  @override
  void convertFromString(dynamic name, String? value) => _convert(name, value);

  void _convert(dynamic name, dynamic value) {
    assert(value == null || value is double || value is String);
    if (value == null) {
      for (Unit unit in _unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    if (value is double) {
      conversionTree.convert(name, Rational.parse(value.toStringAsPrecision(20)));
    } else {
      // value is String
      conversionTree.convert(name, Rational.parse(value));
    }

    for (var i = 0; i < size; i++) {
      Rational? valueAtIndex =
          _nodeList.singleWhere((node) => node.name == _unitList[i].name).value;
      _unitList[i].value = valueAtIndex?.toDouble();
      _unitList[i].stringValue = valueAtIndex?.toStringWith(
          significantFigures: significantFigures,
          removeTrailingZeros: removeTrailingZeros);
    }
  }

  ///Returns all the units converted with prefixes
  @override
  List<Unit> getAll() => _unitList;

  ///Returns the Unit with the corresponding name
  @override
  Unit getUnit(var name) =>
      _unitList.where((element) => element.name == name).single;
}
