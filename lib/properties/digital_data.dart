import 'package:rational/rational.dart';
import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available DIGITAL_DATA units
// ignore: camel_case_types
enum DIGITAL_DATA {
  bit,
  nibble,
  kilobit,
  megabit,
  gigabit,
  terabit,
  petabit,
  exabit,
  kibibit,
  mebibit,
  gibibit,
  tebibit,
  pebibit,
  exbibit,
  byte,
  kilobyte,
  megabyte,
  gigabyte,
  terabyte,
  petabyte,
  exabyte,
  kibibyte,
  mebibyte,
  gibibyte,
  tebibyte,
  pebibyte,
  exbibyte,
}

class DigitalData extends CustomProperty {
  ///Class for digitalData conversions, e.g. if you want to convert 1 megabit in kilobyte:
  ///```dart
  ///var digitalData = DigitalData(removeTrailingZeros: false);
  ///digitalData.convert(Unit(DIGITAL_DATA.megabit, value: 1));
  ///print(DIGITAL_DATA.kilobyte);
  /// ```
  DigitalData(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.digitalData,
          mapSymbols: {
            DIGITAL_DATA.bit: 'b',
            DIGITAL_DATA.kilobit: 'kb',
            DIGITAL_DATA.megabit: 'Mb',
            DIGITAL_DATA.gigabit: 'Gb',
            DIGITAL_DATA.terabit: 'Tb',
            DIGITAL_DATA.petabit: 'Pb',
            DIGITAL_DATA.exabit: 'Eb',
            DIGITAL_DATA.kibibit: 'Kibit',
            DIGITAL_DATA.mebibit: 'Mibit',
            DIGITAL_DATA.gibibit: 'Gibit',
            DIGITAL_DATA.tebibit: 'Tibit',
            DIGITAL_DATA.pebibit: 'Pibit',
            DIGITAL_DATA.exbibit: 'Eibit',
            DIGITAL_DATA.byte: 'B',
            DIGITAL_DATA.kilobyte: 'kB',
            DIGITAL_DATA.megabyte: 'MB',
            DIGITAL_DATA.gigabyte: 'GB',
            DIGITAL_DATA.terabyte: 'TB',
            DIGITAL_DATA.petabyte: 'PB',
            DIGITAL_DATA.exabyte: 'EB',
            DIGITAL_DATA.kibibyte: 'KiB',
            DIGITAL_DATA.mebibyte: 'MiB',
            DIGITAL_DATA.gibibyte: 'GiB',
            DIGITAL_DATA.tebibyte: 'TiB',
            DIGITAL_DATA.pebibyte: 'PiB',
            DIGITAL_DATA.exbibyte: 'EiB',
          },
          conversionTree: ConversionNode(name: DIGITAL_DATA.bit, leafNodes: [
            ConversionNode(
              coefficientProduct: Rational.fromInt(4),
              name: DIGITAL_DATA.nibble,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000),
              name: DIGITAL_DATA.kilobit,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000),
              name: DIGITAL_DATA.megabit,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000000),
              name: DIGITAL_DATA.gigabit,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000000000),
              name: DIGITAL_DATA.terabit,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000000000000),
              name: DIGITAL_DATA.petabit,
            ),
            ConversionNode(
              coefficientProduct: Rational.fromInt(1000000000000000000),
              name: DIGITAL_DATA.exabit,
            ),
            ConversionNode(
                coefficientProduct: Rational.fromInt(1024),
                name: DIGITAL_DATA.kibibit,
                leafNodes: [
                  ConversionNode(
                      coefficientProduct: Rational.fromInt(1024),
                      name: DIGITAL_DATA.mebibit,
                      leafNodes: [
                        ConversionNode(
                            coefficientProduct: Rational.fromInt(1024),
                            name: DIGITAL_DATA.gibibit,
                            leafNodes: [
                              ConversionNode(
                                  coefficientProduct: Rational.fromInt(1024),
                                  name: DIGITAL_DATA.tebibit,
                                  leafNodes: [
                                    ConversionNode(
                                        coefficientProduct:
                                            Rational.fromInt(1024),
                                        name: DIGITAL_DATA.pebibit,
                                        leafNodes: [
                                          ConversionNode(
                                            coefficientProduct:
                                                Rational.fromInt(1024),
                                            name: DIGITAL_DATA.exbibit,
                                          )
                                        ])
                                  ])
                            ])
                      ])
                ]),
            ConversionNode(
                coefficientProduct: Rational.fromInt(8),
                name: DIGITAL_DATA.byte,
                leafNodes: [
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000),
                    name: DIGITAL_DATA.kilobyte,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000000),
                    name: DIGITAL_DATA.megabyte,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000000000),
                    name: DIGITAL_DATA.gigabyte,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000000000000),
                    name: DIGITAL_DATA.terabyte,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000000000000000),
                    name: DIGITAL_DATA.petabyte,
                  ),
                  ConversionNode(
                    coefficientProduct: Rational.fromInt(1000000000000000000),
                    name: DIGITAL_DATA.exabyte,
                  ),
                  ConversionNode(
                      coefficientProduct: Rational.fromInt(1024),
                      name: DIGITAL_DATA.kibibyte,
                      leafNodes: [
                        ConversionNode(
                            coefficientProduct: Rational.fromInt(1024),
                            name: DIGITAL_DATA.mebibyte,
                            leafNodes: [
                              ConversionNode(
                                  coefficientProduct: Rational.fromInt(1024),
                                  name: DIGITAL_DATA.gibibyte,
                                  leafNodes: [
                                    ConversionNode(
                                        coefficientProduct:
                                            Rational.fromInt(1024),
                                        name: DIGITAL_DATA.tebibyte,
                                        leafNodes: [
                                          ConversionNode(
                                              coefficientProduct:
                                                  Rational.fromInt(1024),
                                              name: DIGITAL_DATA.pebibyte,
                                              leafNodes: [
                                                ConversionNode(
                                                  coefficientProduct:
                                                      Rational.fromInt(1024),
                                                  name: DIGITAL_DATA.exbibyte,
                                                ),
                                              ]),
                                        ]),
                                  ]),
                            ]),
                      ]),
                ]),
          ]),
        );

  Unit get bit => getUnit(DIGITAL_DATA.bit);
  Unit get nibble => getUnit(DIGITAL_DATA.nibble);
  Unit get kilobit => getUnit(DIGITAL_DATA.kilobit);
  Unit get megabit => getUnit(DIGITAL_DATA.megabit);
  Unit get gigabit => getUnit(DIGITAL_DATA.gigabit);
  Unit get terabit => getUnit(DIGITAL_DATA.terabit);
  Unit get petabit => getUnit(DIGITAL_DATA.petabit);
  Unit get exabit => getUnit(DIGITAL_DATA.exabit);
  Unit get kibibit => getUnit(DIGITAL_DATA.kibibit);
  Unit get mebibit => getUnit(DIGITAL_DATA.mebibit);
  Unit get gibibit => getUnit(DIGITAL_DATA.gibibit);
  Unit get tebibit => getUnit(DIGITAL_DATA.tebibit);
  Unit get pebibit => getUnit(DIGITAL_DATA.pebibit);
  Unit get exbibit => getUnit(DIGITAL_DATA.exbibit);
  Unit get byte => getUnit(DIGITAL_DATA.byte);
  Unit get kilobyte => getUnit(DIGITAL_DATA.kilobyte);
  Unit get megabyte => getUnit(DIGITAL_DATA.megabyte);
  Unit get gigabyte => getUnit(DIGITAL_DATA.gigabyte);
  Unit get terabyte => getUnit(DIGITAL_DATA.terabyte);
  Unit get petabyte => getUnit(DIGITAL_DATA.petabyte);
  Unit get exabyte => getUnit(DIGITAL_DATA.exabyte);
  Unit get kibibyte => getUnit(DIGITAL_DATA.kibibyte);
  Unit get mebibyte => getUnit(DIGITAL_DATA.mebibyte);
  Unit get gibibyte => getUnit(DIGITAL_DATA.gibibyte);
  Unit get tebibyte => getUnit(DIGITAL_DATA.tebibyte);
  Unit get pebibyte => getUnit(DIGITAL_DATA.pebibyte);
  Unit get exbibyte => getUnit(DIGITAL_DATA.exbibyte);
}
