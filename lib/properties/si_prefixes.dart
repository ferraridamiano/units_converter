import 'package:units_converter/models/conversion_node.dart';
import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/models/custom_property.dart';

//Available SI_PREFIXES units
// ignore: camel_case_types
enum SI_PREFIXES {
  base,
  deca,
  hecto,
  kilo,
  mega,
  giga,
  tera,
  peta,
  exa,
  zetta,
  yotta,
  deci,
  centi,
  milli,
  micro,
  nano,
  pico,
  femto,
  atto,
  zepto,
  yocto,
}

class SIPrefixes extends CustomProperty {
  ///Class for si_prefixes conversions, e.g. if you want to convert 1 base unit in milli:
  ///```dart
  ///var si_prefixes = Si_Prefixes(removeTrailingZeros: false);
  ///si_prefixes.convert(Unit(SI_PREFIXES.base, value: 1));
  ///print(SI_PREFIXES.milli);
  /// ```
  SIPrefixes(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : super(
          name: name ?? PROPERTY.siPrefixes,
          mapSymbols: {
            SI_PREFIXES.deca: 'da-',
            SI_PREFIXES.hecto: 'h-',
            SI_PREFIXES.kilo: 'k-',
            SI_PREFIXES.mega: 'M-',
            SI_PREFIXES.giga: 'G-',
            SI_PREFIXES.tera: 'T-',
            SI_PREFIXES.peta: 'P-',
            SI_PREFIXES.exa: 'E-',
            SI_PREFIXES.zetta: 'Z-',
            SI_PREFIXES.yotta: 'Y-',
            SI_PREFIXES.deci: 'd-',
            SI_PREFIXES.centi: 'c-',
            SI_PREFIXES.milli: 'm-',
            SI_PREFIXES.micro: 'µ-',
            SI_PREFIXES.nano: 'n-',
            SI_PREFIXES.pico: 'p-',
            SI_PREFIXES.femto: 'f-',
            SI_PREFIXES.atto: 'a-',
            SI_PREFIXES.zepto: 'z-',
            SI_PREFIXES.yocto: 'y-',
          },
          conversionTree: ConversionNode(name: SI_PREFIXES.base, leafNodes: [
            ConversionNode(
              coefficientProduct: 1e1,
              name: SI_PREFIXES.deca,
            ),
            ConversionNode(
              coefficientProduct: 1e2,
              name: SI_PREFIXES.hecto,
            ),
            ConversionNode(
              coefficientProduct: 1e3,
              name: SI_PREFIXES.kilo,
            ),
            ConversionNode(
              coefficientProduct: 1e6,
              name: SI_PREFIXES.mega,
            ),
            ConversionNode(
              coefficientProduct: 1e9,
              name: SI_PREFIXES.giga,
            ),
            ConversionNode(
              coefficientProduct: 1e12,
              name: SI_PREFIXES.tera,
            ),
            ConversionNode(
              coefficientProduct: 1e15,
              name: SI_PREFIXES.peta,
            ),
            ConversionNode(
              coefficientProduct: 1e18,
              name: SI_PREFIXES.exa,
            ),
            ConversionNode(
              coefficientProduct: 1e21,
              name: SI_PREFIXES.zetta,
            ),
            ConversionNode(
              coefficientProduct: 1e24,
              name: SI_PREFIXES.yotta,
            ),
            ConversionNode(
              coefficientProduct: 1e-1,
              name: SI_PREFIXES.deci,
            ),
            ConversionNode(
              coefficientProduct: 1e-2,
              name: SI_PREFIXES.centi,
            ),
            ConversionNode(
              coefficientProduct: 1e-3,
              name: SI_PREFIXES.milli,
            ),
            ConversionNode(
              coefficientProduct: 1e-6,
              name: SI_PREFIXES.micro,
            ),
            ConversionNode(
              coefficientProduct: 1e-9,
              name: SI_PREFIXES.nano,
            ),
            ConversionNode(
              coefficientProduct: 1e-12,
              name: SI_PREFIXES.pico,
            ),
            ConversionNode(
              coefficientProduct: 1e-15,
              name: SI_PREFIXES.femto,
            ),
            ConversionNode(
              coefficientProduct: 1e-18,
              name: SI_PREFIXES.atto,
            ),
            ConversionNode(
              coefficientProduct: 1e-21,
              name: SI_PREFIXES.zepto,
            ),
            ConversionNode(
              coefficientProduct: 1e-24,
              name: SI_PREFIXES.yocto,
            ),
          ]),
        );

  Unit get base => getUnit(SI_PREFIXES.base);
  Unit get deca => getUnit(SI_PREFIXES.deca);
  Unit get hecto => getUnit(SI_PREFIXES.hecto);
  Unit get kilo => getUnit(SI_PREFIXES.kilo);
  Unit get mega => getUnit(SI_PREFIXES.mega);
  Unit get giga => getUnit(SI_PREFIXES.giga);
  Unit get tera => getUnit(SI_PREFIXES.tera);
  Unit get peta => getUnit(SI_PREFIXES.peta);
  Unit get exa => getUnit(SI_PREFIXES.exa);
  Unit get zetta => getUnit(SI_PREFIXES.zetta);
  Unit get yotta => getUnit(SI_PREFIXES.yotta);
  Unit get deci => getUnit(SI_PREFIXES.deci);
  Unit get centi => getUnit(SI_PREFIXES.centi);
  Unit get milli => getUnit(SI_PREFIXES.milli);
  Unit get micro => getUnit(SI_PREFIXES.micro);
  Unit get nano => getUnit(SI_PREFIXES.nano);
  Unit get pico => getUnit(SI_PREFIXES.pico);
  Unit get femto => getUnit(SI_PREFIXES.femto);
  Unit get atto => getUnit(SI_PREFIXES.atto);
  Unit get zepto => getUnit(SI_PREFIXES.zepto);
  Unit get yocto => getUnit(SI_PREFIXES.yocto);
}
