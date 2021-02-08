import 'Property.dart';
import 'UtilsConversion.dart';
import 'Unit.dart';

//Available DIGITAL_DATA units
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

class DigitalData extends Property<DIGITAL_DATA, double> {
  //Map between units and its symbol
  final Map<DIGITAL_DATA, String> mapSymbols = {
    DIGITAL_DATA.bit: 'b',
    DIGITAL_DATA.nibble: null,
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
  };

  int significantFigures;
  bool removeTrailingZeros;

  ///Class for digitalData conversions, e.g. if you want to convert 1 megabit in kilobyte:
  ///```dart
  ///var digitalData = DigitalData(removeTrailingZeros: false);
  ///digitalData.Convert(Unit(DIGITAL_DATA.megabit, value: 1));
  ///print(DIGITAL_DATA.kilobyte);
  /// ```
  DigitalData({this.significantFigures = 10, this.removeTrailingZeros = true, name}) {
    this.name = name ?? PROPERTY.DIGITAL_DATA;
    DIGITAL_DATA.values.forEach((element) => unitList.add(Unit(element, symbol: mapSymbols[element])));
    unit_conversion = Node(name: DIGITAL_DATA.bit, leafNodes: [
      Node(
        coefficientProduct: 4.0,
        name: DIGITAL_DATA.nibble,
      ),
      Node(
        coefficientProduct: 1e3,
        name: DIGITAL_DATA.kilobit,
      ),
      Node(
        coefficientProduct: 1e6,
        name: DIGITAL_DATA.megabit,
      ),
      Node(
        coefficientProduct: 1e9,
        name: DIGITAL_DATA.gigabit,
      ),
      Node(
        coefficientProduct: 1e12,
        name: DIGITAL_DATA.terabit,
      ),
      Node(
        coefficientProduct: 1e15,
        name: DIGITAL_DATA.petabit,
      ),
      Node(
        coefficientProduct: 1e18,
        name: DIGITAL_DATA.exabit,
      ),
      Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.kibibit, leafNodes: [
        Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.mebibit, leafNodes: [
          Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.gibibit, leafNodes: [
            Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.tebibit, leafNodes: [
              Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.pebibit, leafNodes: [
                Node(
                  coefficientProduct: 1024.0,
                  name: DIGITAL_DATA.exbibit,
                )
              ])
            ])
          ])
        ])
      ]),
      Node(coefficientProduct: 8.0, name: DIGITAL_DATA.byte, leafNodes: [
        Node(
          coefficientProduct: 1e3,
          name: DIGITAL_DATA.kilobyte,
        ),
        Node(
          coefficientProduct: 1e6,
          name: DIGITAL_DATA.megabyte,
        ),
        Node(
          coefficientProduct: 1e9,
          name: DIGITAL_DATA.gigabyte,
        ),
        Node(
          coefficientProduct: 1e12,
          name: DIGITAL_DATA.terabyte,
        ),
        Node(
          coefficientProduct: 1e15,
          name: DIGITAL_DATA.petabyte,
        ),
        Node(
          coefficientProduct: 1e18,
          name: DIGITAL_DATA.exabyte,
        ),
        Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.kibibyte, leafNodes: [
          Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.mebibyte, leafNodes: [
            Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.gibibyte, leafNodes: [
              Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.tebibyte, leafNodes: [
                Node(coefficientProduct: 1024.0, name: DIGITAL_DATA.pebibyte, leafNodes: [
                  Node(
                    coefficientProduct: 1024.0,
                    name: DIGITAL_DATA.exbibyte,
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]);
  }

  ///Converts a unit with a specific name (e.g. DIGITAL_DATA.byte) and value to all other units
  @override
  void convert(DIGITAL_DATA name, double value) {
    super.convert(name, value);
    if (value == null) return;
    for (var i = 0; i < DIGITAL_DATA.values.length; i++) {
      unitList[i].value = unit_conversion.getByName(DIGITAL_DATA.values.elementAt(i)).value;
      unitList[i].stringValue = mantissaCorrection(unitList[i].value, significantFigures, removeTrailingZeros);
    }
  }

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
