import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/properties/mass.dart';
import 'package:units_converter/properties/volume.dart';
import 'package:units_converter/utils/utils.dart';

enum DENSITY {
  gramsPerLiter(MASS.grams, VOLUME.liters),
  gramsPerCubicCentimeter(MASS.grams, VOLUME.cubicCentimeters),
  kilogramsPerLiter(MASS.kilograms, VOLUME.liters),
  kilogramsPerCubicMeter(MASS.kilograms, VOLUME.cubicMeters),
  nanoGramsPerMilliLiter(MASS.nanograms, VOLUME.milliliters),
  picoGramsPerMilliLiter(MASS.picograms, VOLUME.milliliters),
  microGramsPerDeciLiter(MASS.micrograms, VOLUME.deciliters),
  microGramsPerMilliLiter(MASS.micrograms, VOLUME.milliliters);

  final MASS numerator;
  final VOLUME denominator;
  const DENSITY(this.numerator, this.denominator);
}

class Density extends RatioProperty<DENSITY, MASS, VOLUME> {
  // NOTE: All values of DENSITY must be reported in this variable
  static const Map<DENSITY, String?> _mapSymbols = {
    DENSITY.gramsPerLiter: 'g/l',
    DENSITY.gramsPerCubicCentimeter: 'g/cm³',
    DENSITY.kilogramsPerLiter: 'kg/l',
    DENSITY.kilogramsPerCubicMeter: 'kg/m³',
    DENSITY.nanoGramsPerMilliLiter: 'ng/ml',
    DENSITY.picoGramsPerMilliLiter: 'pg/ml',
    DENSITY.microGramsPerDeciLiter: 'µg/dl',
    DENSITY.microGramsPerMilliLiter: 'µg/ml',
  };

  ///Class for density conversions, e.g. if you want to convert 1 gram per liter
  ///in kilograms per liter:
  ///```dart
  ///var density = Density(removeTrailingZeros: false);
  ///density.convert(Unit(DENSITY.gramsPerLiter, value: 1));
  ///print(DENSITY.kilogramsPerLiter);
  /// ```
  Density(
      {super.significantFigures,
      super.removeTrailingZeros,
      super.useScientificNotation,
      name})
      : assert(_mapSymbols.length == DENSITY.values.length),
        super(
            name: name ?? PROPERTY.density,
            numeratorProperty:
                getPropertyFromEnum(DENSITY.values[0].numerator)!,
            denominatorProperty:
                getPropertyFromEnum(DENSITY.values[0].denominator)!,
            mapSymbols: _mapSymbols);

  Unit get gramsPerLiter => getUnit(DENSITY.gramsPerLiter);
  Unit get gramsPerCubicCentimeter => getUnit(DENSITY.gramsPerCubicCentimeter);
  Unit get kilogramsPerLiter => getUnit(DENSITY.kilogramsPerLiter);
  Unit get kilogramsPerCubicMeter => getUnit(DENSITY.kilogramsPerCubicMeter);
  Unit get nanoGramsPerMilliLiter => getUnit(DENSITY.nanoGramsPerMilliLiter);
  Unit get picoGramsPerMilliLiter => getUnit(DENSITY.picoGramsPerMilliLiter);
  Unit get microGramsPerDeciLiter => getUnit(DENSITY.microGramsPerDeciLiter);
  Unit get microGramsPerMilliLiter => getUnit(DENSITY.microGramsPerMilliLiter);
}
