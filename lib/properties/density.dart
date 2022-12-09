import 'package:units_converter/models/property.dart';
import 'package:units_converter/models/ratio_property.dart';
import 'package:units_converter/models/unit.dart';
import 'package:units_converter/properties/mass.dart';
import 'package:units_converter/properties/volume.dart';
import 'package:units_converter/utils/utils.dart';

enum DENSITY {
  gramsPerLiter(MASS.grams, VOLUME.liters),
  gramsPerCubicCentimeter(MASS.grams, VOLUME.cubicCentimeters),
  gramsPerMilliLiter(MASS.grams, VOLUME.milliliters),
  gramsPerDeciLiter(MASS.grams, VOLUME.deciliters),
  kilogramsPerLiter(MASS.kilograms, VOLUME.liters),
  kilogramsPerCubicMeter(MASS.kilograms, VOLUME.cubicMeters),
  milliGramsPerLiter(MASS.milligrams, VOLUME.liters),
  milliGramsPerDeciLiter(MASS.milligrams, VOLUME.deciliters),
  milliGramsPerMilliLiter(MASS.milligrams, VOLUME.milliliters),
  milliGramsPerCubicMeter(MASS.milligrams, VOLUME.cubicMeters),
  milliGramsPerCubicCentimeter(MASS.milligrams, VOLUME.cubicCentimeters),
  microGramsPerLiter(MASS.micrograms, VOLUME.liters),
  microGramsPerDeciLiter(MASS.micrograms, VOLUME.deciliters),
  microGramsPerMilliLiter(MASS.micrograms, VOLUME.milliliters),
  nanoGramsPerLiter(MASS.nanograms, VOLUME.liters),
  nanoGramsPerMilliLiter(MASS.nanograms, VOLUME.milliliters),
  picoGramsPerLiter(MASS.picograms, VOLUME.liters),
  picoGramsPerMilliLiter(MASS.picograms, VOLUME.milliliters),
  ;

  final MASS numerator;
  final VOLUME denominator;
  const DENSITY(this.numerator, this.denominator);
}

class Density extends RatioProperty<DENSITY, MASS, VOLUME> {
  // NOTE: All values of DENSITY must be reported in this variable
  static const Map<DENSITY, String?> _mapSymbols = {
    DENSITY.gramsPerLiter: 'g/l',
    DENSITY.gramsPerCubicCentimeter: 'g/cm³',
    DENSITY.gramsPerMilliLiter: 'g/ml',
    DENSITY.gramsPerDeciLiter: 'g/dl',
    DENSITY.kilogramsPerLiter: 'kg/l',
    DENSITY.kilogramsPerCubicMeter: 'kg/m³',
    DENSITY.milliGramsPerLiter: 'mg/l',
    DENSITY.milliGramsPerDeciLiter: 'mg/dl',
    DENSITY.milliGramsPerMilliLiter: 'mg/ml',
    DENSITY.milliGramsPerCubicMeter: 'mg/m³',
    DENSITY.milliGramsPerCubicCentimeter: 'mg/cm³',
    DENSITY.microGramsPerLiter: 'µg/l',
    DENSITY.microGramsPerDeciLiter: 'µg/dl',
    DENSITY.microGramsPerMilliLiter: 'µg/ml',
    DENSITY.nanoGramsPerLiter: 'ng/l',
    DENSITY.nanoGramsPerMilliLiter: 'ng/ml',
    DENSITY.picoGramsPerLiter: 'pg/l',
    DENSITY.picoGramsPerMilliLiter: 'pg/ml',
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
  Unit get gramsPerMilliLiter => getUnit(DENSITY.gramsPerMilliLiter);
  Unit get gramsPerDeciLiter => getUnit(DENSITY.gramsPerDeciLiter);
  Unit get kilogramsPerLiter => getUnit(DENSITY.kilogramsPerLiter);
  Unit get kilogramsPerCubicMeter => getUnit(DENSITY.kilogramsPerCubicMeter);
  Unit get milliGramsPerLiter => getUnit(DENSITY.milliGramsPerLiter);
  Unit get milliGramsPerDeciLiter => getUnit(DENSITY.milliGramsPerDeciLiter);
  Unit get milliGramsPerMilliLiter => getUnit(DENSITY.milliGramsPerMilliLiter);
  Unit get milliGramsPerCubicMeter => getUnit(DENSITY.milliGramsPerCubicMeter);
  Unit get milliGramsPerCubicCentimeter =>
      getUnit(DENSITY.milliGramsPerCubicCentimeter);
  Unit get microGramsPerLiter => getUnit(DENSITY.microGramsPerLiter);
  Unit get microGramsPerDeciLiter => getUnit(DENSITY.microGramsPerDeciLiter);
  Unit get microGramsPerMilliLiter => getUnit(DENSITY.microGramsPerMilliLiter);
  Unit get nanoGramsPerLiter => getUnit(DENSITY.nanoGramsPerLiter);
  Unit get nanoGramsPerMilliLiter => getUnit(DENSITY.nanoGramsPerMilliLiter);
  Unit get picoGramsPerLiter => getUnit(DENSITY.picoGramsPerLiter);
  Unit get picoGramsPerMilliLiter => getUnit(DENSITY.picoGramsPerMilliLiter);
}
