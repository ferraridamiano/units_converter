import 'package:units_converter/models/node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_conversion.dart';

//Available SHOE_SIZE units
enum SHOE_SIZE {
  centimeters,
  inches,
  euChina,
  ukIndiaChild,
  ukIndiaMan,
  ukIndiaWoman,
  usaCanadaChild,
  usaCanadaMan,
  usaCanadaWoman,
  japan,
}

class ShoeSize extends Property<SHOE_SIZE, double> {
  /// Map between units and its symbol
  final Map<SHOE_SIZE, String> mapSymbols = {
    SHOE_SIZE.centimeters: 'cm',
    SHOE_SIZE.inches: 'in',
  };

  /// The number of significan figures to keep. E.g. 1.23456789) has 9
  /// significant figures
  int significantFigures;

  /// Whether to remove the trailing zeros or not. E.g 1.00000000 has 9
  /// significant figures and has trailing zeros. 1 has not trailing zeros.
  bool removeTrailingZeros;

  late CustomConversion _customConversion;

  ///Class for ShoeSize conversions, e.g. if you want to convert 1 centimeter in eu shoes size:
  ///```dart
  ///var ShoeSize = ShoeSize(removeTrailingZeros: false);
  ///ShoeSize.convert(Unit(SHOE_SIZE.centimeters, value: 1));
  ///print(SHOE_SIZE.eu_china);
  /// ```
  ShoeSize(
      {this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    Node conversionTree = Node(name: SHOE_SIZE.centimeters, leafNodes: [
      Node(
        coefficientProduct: 1 / 1.5,
        coefficientSum: -1.5,
        name: SHOE_SIZE.euChina,
      ),
      Node(coefficientProduct: 2.54, name: SHOE_SIZE.inches, leafNodes: [
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 10 / 3,
          name: SHOE_SIZE.ukIndiaChild,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 23 / 3,
          name: SHOE_SIZE.ukIndiaMan,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 23.5 / 3,
          name: SHOE_SIZE.ukIndiaWoman,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 49 / 9,
          name: SHOE_SIZE.usaCanadaChild,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 22 / 3,
          name: SHOE_SIZE.usaCanadaMan,
        ),
        Node(
          coefficientProduct: 1 / 3,
          coefficientSum: 21 / 3,
          name: SHOE_SIZE.usaCanadaWoman,
        ),
      ]),
      Node(
        coefficientSum: -1.5,
        name: SHOE_SIZE.japan,
      ),
    ]);
    
    _customConversion = CustomConversion(
        conversionTree: conversionTree,
        mapSymbols: mapSymbols,
        significantFigures: significantFigures,
        removeTrailingZeros: removeTrailingZeros,
        name: name ?? PROPERTY.angle);
  }

  ///Converts a unit with a specific name (e.g. SHOE_SIZE.uk_india_woman) and value to all other units
  @override
  void convert(SHOE_SIZE name, double? value) =>
      _customConversion.convert(name, value);
  @override
  List<Unit> getAll() => _customConversion.getAll();
  @override
  Unit getUnit(name) => _customConversion.getUnit(name);

  Unit get centimeters => getUnit(SHOE_SIZE.centimeters);
  Unit get inches => getUnit(SHOE_SIZE.inches);
  Unit get euChina => getUnit(SHOE_SIZE.euChina);
  Unit get ukIndiaChild => getUnit(SHOE_SIZE.ukIndiaChild);
  Unit get ukIndiaMan => getUnit(SHOE_SIZE.ukIndiaMan);
  Unit get ukIndiaWoman => getUnit(SHOE_SIZE.ukIndiaWoman);
  Unit get usaCanadaChild => getUnit(SHOE_SIZE.usaCanadaChild);
  Unit get usaCanadaMan => getUnit(SHOE_SIZE.usaCanadaMan);
  Unit get usaCanadaWoman => getUnit(SHOE_SIZE.usaCanadaWoman);
  Unit get japan => getUnit(SHOE_SIZE.japan);
}