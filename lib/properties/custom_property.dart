import 'package:units_converter/models/double_property.dart';

class CustomProperty extends DoubleProperty<String> {
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
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      required super.conversionTree,
      super.mapSymbols,
      name})
      : super(name: name ?? 'CustomProperty');
}
