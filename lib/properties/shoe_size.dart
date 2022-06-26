import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';
import 'package:units_converter/utils/utils.dart';

//Available SHOE_SIZE units
// ignore: camel_case_types
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

class ShoeSize extends CustomProperty {
  ///Class for ShoeSize conversions, e.g. if you want to convert 1 centimeter in eu shoes size:
  ///```dart
  ///var ShoeSize = ShoeSize(removeTrailingZeros: false);
  ///ShoeSize.convert(Unit(SHOE_SIZE.centimeters, value: 1));
  ///print(SHOE_SIZE.eu_china);
  /// ```
  ShoeSize(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.shoeSize,
          mapSymbols: {
            SHOE_SIZE.centimeters: 'cm',
            SHOE_SIZE.inches: 'in',
          },
          conversionTree:
              ConversionNode(name: SHOE_SIZE.centimeters, leafNodes: [
            ConversionNode(
              coefficientProduct: fraction(2, 3),
              coefficientSum: Rational.parse('-1.5'),
              name: SHOE_SIZE.euChina,
            ),
            ConversionNode(
                coefficientProduct: Rational.parse('2.54'),
                name: SHOE_SIZE.inches,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: fraction(1, 3),
                    coefficientSum: fraction(10, 3),
                    name: SHOE_SIZE.ukIndiaChild,
                  ),
                  ConversionNode(
                    coefficientProduct: fraction(1, 3),
                    coefficientSum: fraction(23, 3),
                    name: SHOE_SIZE.ukIndiaMan,
                  ),
                  ConversionNode(
                    coefficientProduct: fraction(1, 3),
                    coefficientSum: fraction(47, 6),
                    name: SHOE_SIZE.ukIndiaWoman,
                  ),
                  ConversionNode(
                    coefficientProduct: fraction(1, 3),
                    coefficientSum: fraction(49, 9),
                    name: SHOE_SIZE.usaCanadaChild,
                  ),
                  ConversionNode(
                    coefficientProduct: fraction(1, 3),
                    coefficientSum: fraction(22, 3),
                    name: SHOE_SIZE.usaCanadaMan,
                  ),
                  ConversionNode(
                    coefficientProduct: fraction(1, 3),
                    coefficientSum: fraction(21, 3),
                    name: SHOE_SIZE.usaCanadaWoman,
                  ),
                ]),
            ConversionNode(
              coefficientSum: Rational.parse('-1.5'),
              name: SHOE_SIZE.japan,
            ),
          ]),
        );

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
