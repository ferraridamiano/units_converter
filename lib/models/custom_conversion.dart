import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/utils/utils.dart';

class CustomConversion extends Property<dynamic, double> {
  //Map between units and its symbol
  final Map<dynamic, String?> mapSymbols;
  int significantFigures;
  bool removeTrailingZeros;
  final dynamic name;
  final List<Unit> _unitList = [];
  late List<Node> _nodeList;
  Node conversionTree;

  ///Class for angle conversions, e.g. if you want to convert 1 radiant in degree:
  ///```dart
  ///var angle = Angle(removeTrailingZeros: false);
  ///angle.convert(Unit(ANGLE.radians, value: 1));
  ///print(ANGLE.degree);
  /// ```
  CustomConversion(
      {required this.conversionTree,
      required this.mapSymbols,
      required this.name,
      this.significantFigures = 10,
      this.removeTrailingZeros = true}) {
    mapSymbols.forEach((key, value) => _unitList.add(Unit(key, symbol: value)));
    _nodeList = conversionTree.getTreeAsList();
  }

  /// Converts a unit with a specific name (e.g. ANGLE.degree) and value to all
  /// other units
  @override
  void convert(dynamic name, double? value) {
    if (value == null) {
      for (Unit unit in _unitList) {
        unit.value = null;
        unit.stringValue = null;
      }
      return;
    }
    conversionTree.convert(name, value);
    for (var i = 0; i < mapSymbols.length; i++) {
      _unitList[i].value =
          _nodeList.singleWhere((node) => node.name == _unitList[i].name).value;
      _unitList[i].stringValue = mantissaCorrection(
          _unitList[i].value!, significantFigures, removeTrailingZeros);
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
